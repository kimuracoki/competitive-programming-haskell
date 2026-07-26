# 対象の問題ディレクトリ。既定は「最後に編集した Main.hs のあるディレクトリ」。
# 明示するなら just dir=problems/abc/abc268/b-prefix t
dir := `ls -t problems/*/*/Main.hs problems/*/*/*/Main.hs 2>/dev/null | head -1 | xargs dirname`

oj := "uv run oj"

# レシピ一覧と、いまの対象ディレクトリ
default:
    @echo "対象: {{dir}}"
    @just --list --unsorted

# URL から置き場所を決め、ひな形・見出し・サンプルを用意する
new url:
    #!/usr/bin/env bash
    set -euo pipefail
    contest=$(printf '%s' "{{url}}" | sed -n 's|.*/contests/\([^/]*\)/.*|\1|p')
    title=$(curl -sf "{{url}}" | tr -d '\n' \
            | sed -n 's|.*<title>\(.*\)</title>.*|\1|p' \
            | sed 's/&#43;/+/g; s/&lt;/</g; s/&gt;/>/g; s/&quot;/"/g; s/&amp;/\&/g')
    [ -n "$title" ] || { echo "タイトルを取得できませんでした: {{url}}" >&2; exit 1; }
    slug=$(printf '%s' "$title" | tr 'A-Z' 'a-z' \
           | sed 's/+/ plus /g; s/[^a-z0-9]\{1,\}/-/g; s/^-//; s/-$//')
    case $contest in
      abc[0-9]*|arc[0-9]*|agc[0-9]*) group="${contest%%[0-9]*}/$contest" ;;
      *)                             group="$contest" ;;
    esac
    target="problems/$group/$slug"
    [ -e "$target" ] && { echo "$target はすでにあります" >&2; exit 1; }
    mkdir -p "$target"
    { printf -- '-- %s\n-- %s\n\n' "$title" "{{url}}"; cat template/Main.hs; } > "$target/Main.hs"
    (cd "$target" && {{oj}} d "{{url}}")
    echo
    echo "created: $target"

# ブラウザの REVEL_SESSION クッキーを oj と acc に書き込む
#
# AtCoder が reCAPTCHA を入れたため acc login / oj login のパスワード認証は通らない。
# ブラウザで AtCoder にログインした状態で
#   DevTools → Application → Cookies → https://atcoder.jp → REVEL_SESSION
# の値をコピーしてから実行する。入力は画面に出ないし、シェル履歴にも残らない。
login:
    #!/usr/bin/env bash
    set -euo pipefail
    read -rsp 'REVEL_SESSION: ' value; echo
    [ -n "$value" ] || { echo "空でした" >&2; exit 1; }
    # oj (LWPCookieJar)
    REVEL_SESSION="$value" uv run python - <<'PY'
    import http.cookiejar, os, pathlib
    from onlinejudge_command.utils import default_cookie_path
    path = pathlib.Path(default_cookie_path)
    path.parent.mkdir(parents=True, exist_ok=True)
    jar = http.cookiejar.LWPCookieJar(str(path))
    if path.exists():
        jar.load(ignore_discard=True)
    jar.set_cookie(http.cookiejar.Cookie(
        version=0, name='REVEL_SESSION', value=os.environ['REVEL_SESSION'],
        port=None, port_specified=False,
        domain='atcoder.jp', domain_specified=True, domain_initial_dot=False,
        path='/', path_specified=True, secure=True, expires=None,
        discard=False, comment=None, comment_url=None, rest={}, rfc2109=False))
    jar.save(ignore_discard=True)
    print(f'oj  : {path}')
    PY
    # acc
    cfg="$(acc config-dir)/session.json"
    REVEL_SESSION="$value" ACC_SESSION="$cfg" uv run python - <<'PY'
    import json, os, pathlib
    path = pathlib.Path(os.environ['ACC_SESSION'])
    path.write_text(json.dumps({'cookies': ['REVEL_SESSION=' + os.environ['REVEL_SESSION']]}, indent=1))
    print(f'acc : {path}')
    PY
    echo
    just check

# ログイン状態を確認する
check:
    -uv run oj login --check https://atcoder.jp
    -acc session

# サンプル全件テスト
t:
    cd {{dir}} && {{oj}} t -c "runghc Main.hs"

# 提出（提出先は Main.hs 2 行目の URL から取る）
s:
    #!/usr/bin/env bash
    set -euo pipefail
    url=$(sed -n '2s|^-- \(https\{0,1\}://.*\)|\1|p' {{dir}}/Main.hs)
    [ -n "$url" ] || { echo "{{dir}}/Main.hs の 2 行目に問題 URL がありません" >&2; exit 1; }
    cd {{dir}} && {{oj}} s "$url" Main.hs

# doctest（solve の部品を試す用）
doc:
    doctest {{dir}}/Main.hs

# コンテスト全問をまとめて用意する（atcoder-cli）
contest id:
    #!/usr/bin/env bash
    set -euo pipefail
    case {{id}} in
      abc[0-9]*|arc[0-9]*|agc[0-9]*) group=$(printf '%s' "{{id}}" | sed 's/[0-9]*$//') ;;
      *)                             group="{{id}}" ;;
    esac
    mkdir -p "problems/$group"
    cd "problems/$group" && acc new {{id}}
