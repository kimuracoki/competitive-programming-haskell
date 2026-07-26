#!/bin/sh
# 各 Main.hs のヘッダから出題元ごとの一覧表を生成し、
# problems/<source>/README.md の index マーカーの間を差し替える。
#
#   ./index.sh
#
# 表は生成物なので手で編集しない。タイトル・URL・Status は
# Main.hs の先頭 3 行を直すこと。
set -eu

root=$(cd "$(dirname "$0")" && pwd)

for source_readme in "$root"/problems/*/README.md; do
    source_dir=$(dirname "$source_readme")
    source_name=$(basename "$source_dir")

    if ! grep -q '<!-- index:start -->' "$source_readme"; then
        echo "problems/$source_name/README.md に <!-- index:start --> がありません" >&2
        continue
    fi

    table=$(mktemp)
    {
        printf '%s\n' "| Problem | Directory | Status |"
        printf '%s\n' "|---------|-----------|--------|"
        find "$source_dir" -name Main.hs | sort | while read -r main; do
            dir=$(dirname "$main")
            rel=${dir#"$source_dir"/}
            title=$(sed -n '1s|^-- *||p' "$main")
            url=$(sed -n 's|^-- \(https\{0,1\}://.*\)|\1|p' "$main" | head -1)
            status=$(sed -n 's|^-- Status: *||p' "$main" | head -1)
            printf '%s\n' "| [${title:-?}](${url:-#}) | [$rel]($rel/Main.hs) | ${status:-?} |"
        done
    } > "$table"

    awk -v table="$table" '
        /<!-- index:start -->/ { print; while ((getline line < table) > 0) print line; skip = 1; next }
        /<!-- index:end -->/   { skip = 0 }
        !skip
    ' "$source_readme" > "$source_readme.tmp"

    mv "$source_readme.tmp" "$source_readme"
    rm -f "$table"
    echo "updated problems/$source_name/README.md"
done
