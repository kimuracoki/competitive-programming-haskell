# 対象の問題ディレクトリ。既定は「最後に編集した Main.hs のあるディレクトリ」。
# 明示するなら just dir=problems/abc/abc268/b-prefix t
dir := `ls -t problems/*/*/Main.hs problems/*/*/*/Main.hs 2>/dev/null | head -1 | xargs dirname`

# oj は起動のたびに PyPI へ更新確認に行く（キャッシュは 8 時間）。
# 回線しだいでそこで固まるので、確認だけ潰して本体を呼ぶ。
oj := "uv run python -c 'from onlinejudge_command import main, update_checking; update_checking.run = lambda: True; main.main()'"

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
login:
    #!/usr/bin/env bash
    set -euo pipefail
    # AtCoder が reCAPTCHA を入れたため acc login / oj login のパスワード認証は通らない。
    # ブラウザで AtCoder にログインした状態で
    #   DevTools → Application → Cookies → https://atcoder.jp → REVEL_SESSION
    # の値をコピーしてから実行する。入力は画面に出ないし、シェル履歴にも残らない。
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

# サンプル全件テスト（ジャッジと同じ -O2、AtCoder と同じ 2 秒制限）
t:
    #!/usr/bin/env bash
    set -euo pipefail
    # runghc はインタプリタなので 10^8 回ループに 14 秒（コンパイル版は 0.15 秒）かかり、
    # TLE かどうかが手元で分からなかった。コンパイル自体は 0.1〜0.4 秒で runghc の起動より短い。
    # 中間生成物（.hi/.o と実行ファイル）は .build/ に逃がし、problems/ を汚さない。
    out="$PWD/.build/{{dir}}"
    mkdir -p "$out"
    # macOS では GHC が渡す -undefined dynamic_lookup にリンカが毎回警告を出す。
    # 中身のない警告なので黙らせる（GNU ld には無いオプションなので Darwin 限定）。
    quiet=()
    [ "$(uname)" = Darwin ] && quiet=(-optl-Wl,-w)
    ghc -v0 -O2 "${quiet[@]}" -outputdir "$out" -o "$out/main" {{dir}}/Main.hs
    cd {{dir}} && {{oj}} t --tle 2 -c "$out/main"

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
    # acc のグローバル設定をこのリポジトリから独立させる。
    # acc は oj を見つけると、その絶対パスを自分の config.json に保存してしまうので、
    # --no-tests で oj を使わせない。acc には問題一覧の取得だけさせ、
    # テンプレート配布（--no-template）とサンプル取得は後処理でこちらがやる。
    template=$PWD/template/Main.hs
    mkdir -p "problems/$group"
    cd "problems/$group" && acc new {{id}} --no-template --no-tests
    # acc はディレクトリ名を問題ラベルだけ（a, b, …）にする。
    # just new と同じ「ラベル-公式タイトル」に揃え、Main.hs を置いて URL を 2 行目に入れる。
    cd {{id}} && TEMPLATE=$template uv run python - <<'PY'
    import json, os, pathlib, re, subprocess

    def slugify(s):
        s = s.lower().replace('+', ' plus ')
        return re.sub(r'-+$', '', re.sub(r'^-+', '', re.sub(r'[^a-z0-9]+', '-', s)))

    template = pathlib.Path(os.environ['TEMPLATE']).read_text()
    meta = pathlib.Path('contest.acc.json')
    data = json.loads(meta.read_text())
    for task in data['tasks']:
        old = pathlib.Path(task['directory']['path'])
        heading = f"{task['label']} - {task['title']}"
        new = pathlib.Path(slugify(heading))
        if old != new and old.is_dir():
            old.rename(new)
            task['directory']['path'] = str(new)
        new.mkdir(exist_ok=True)
        main = new / 'Main.hs'
        if not main.is_file():
            main.write_text(f"-- {heading}\n-- {task['url']}\n\n" + template)
        # uv run 配下なので .venv/bin が PATH にある。インタラクティブ問題など
        # サンプルが無い問題では oj が失敗するが、それは無視して続ける。
        if not (new / 'test').is_dir():
            subprocess.run(['oj', 'd', task['url']], cwd=new,
                           stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    meta.write_text(json.dumps(data, indent=2) + '\n')
    got = sum(1 for t in data['tasks'] if (pathlib.Path(t['directory']['path']) / 'test').is_dir())
    print(f"{len(data['tasks'])} 問を用意（うち {got} 問はサンプル取得済み）")
    PY
