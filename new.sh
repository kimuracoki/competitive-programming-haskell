#!/bin/sh
# 問題ページの URL だけから Main.hs を作る。
#
#   ./new.sh https://atcoder.jp/contests/abc268/tasks/abc268_b
#     -> problems/abc/abc268/b-prefix/Main.hs
#
#   ./new.sh https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_q
#     -> problems/math-and-algorithm/017-least-common-multiple-of-n-integers/Main.hs
#
# 置き場所とディレクトリ名は URL と公式タイトルから決まる。
# サンプルは問題ページから取ってきて doctest として埋め込むので、手で貼るものはない。
set -eu

if [ $# -ne 1 ]; then
    echo "usage: $0 <problem-url>" >&2
    exit 1
fi

root=$(cd "$(dirname "$0")" && pwd)
url=$1
page=$(mktemp)
trap 'rm -f "$page"' EXIT

curl -sf "$url" | tr -d '\r' > "$page" || { echo "取得できませんでした: $url" >&2; exit 1; }

unescape() {
    sed 's/&lt;/</g; s/&gt;/>/g; s/&quot;/"/g; s/&#39;/'"'"'/g; s/&#43;/+/g; s/&amp;/\&/g'
}

title=$(tr -d '\n' < "$page" | sed -n 's|.*<title>\(.*\)</title>.*|\1|p' | unescape)
if [ -z "$title" ]; then
    echo "タイトルを取得できませんでした。URL を確認してください: $url" >&2
    exit 1
fi

# /contests/<contest>/tasks/<task> の <contest> で置き場所を決める。
# abc/arc/agc はコンテストが積み上がるので 1 階層挟む。
contest=$(printf '%s' "$url" | sed -n 's|.*/contests/\([^/]*\)/.*|\1|p')
case $contest in
    abc[0-9]*) group="abc/$contest" ;;
    arc[0-9]*) group="arc/$contest" ;;
    agc[0-9]*) group="agc/$contest" ;;
    *)         group=$contest ;;
esac

# "B - Prefix?" -> "b-prefix"、"006 - Print 2N+3" -> "006-print-2n-plus-3"
slug=$(printf '%s' "$title" \
    | tr 'A-Z' 'a-z' \
    | sed 's/+/ plus /g' \
    | sed 's/[^a-z0-9]\{1,\}/-/g; s/^-//; s/-$//')

dir="$root/problems/$group/$slug"
[ -e "$dir" ] && { echo "$dir はすでにあります" >&2; exit 1; }

# <h3>入力例 N</h3><pre>...</pre> の中身を取り出し、Haskell の文字列リテラルに変換する。
sample() { # $1: 入力例|出力例  $2: 番号
    sed -n "/<h3>$1 $2<\/h3><pre>/,/<\/pre>/p" "$page" \
        | sed "s|.*<h3>$1 $2</h3><pre>||; s|</pre>.*||" \
        | sed 's/<[^>]*>//g' \
        | unescape \
        | sed '${/^$/d;}' \
        | sed 's/\\/\\\\/g; s/"/\\"/g' \
        | sed 's/$/\\n/' \
        | tr -d '\n'
}

doctests=$(mktemp)
trap 'rm -f "$page" "$doctests"' EXIT
n=1
while :; do
    in=$(sample 入力例 "$n")
    out=$(sample 出力例 "$n")
    [ -z "$in" ] && break
    # echo は \n を解釈してしまう環境があるので printf '%s\n' で書く。
    [ "$n" -eq 1 ] && printf '%s\n' "-- |" >> "$doctests"
    printf '%s\n' "-- >>> solve \"$in\"" >> "$doctests"
    printf '%s\n' "-- \"$out\"" >> "$doctests"
    n=$((n + 1))
done
count=$((n - 1))

if [ "$count" -eq 0 ]; then
    {
        printf '%s\n' "-- |"
        printf '%s\n' '-- 例)  >>> solve "5\n1 2 3 4 5\n"'
        printf '%s\n' '--      "3\n"'
    } >> "$doctests"
fi

mkdir -p "$dir"
{
    printf '%s\n' "-- $title"
    printf '%s\n' "-- $url"
    printf '%s\n' "-- Status: WIP"
    printf '\n'
    printf '%s\n' "main :: IO ()"
    printf '%s\n' "main = interact solve"
    printf '\n'
    cat "$doctests"
    printf '%s\n' "solve :: String -> String"
    printf '%s\n' "solve = undefined"
} > "$dir/Main.hs"

echo "$title"
echo "  problems/$group/$slug/Main.hs"
if [ "$count" -gt 0 ]; then
    echo "  サンプル $count 件を doctest として取り込みました"
else
    echo "  サンプルを取得できなかったので doctest はひな形のままです"
fi
echo
echo "次:  1. solve を書く（型は問題に合わせて変えてよい）"
echo "     2. doctest problems/$group/$slug/Main.hs"
echo "     3. 提出したら Status: を直して ./index.sh"
