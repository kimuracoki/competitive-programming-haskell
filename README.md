# competitive-programming-haskell

AtCoder を Haskell で解いた記録。解答は [`problems/`](problems/README.md) に 1 問 1 ディレクトリ。

## 問題を解く

```sh
just new https://atcoder.jp/contests/abc268/tasks/abc268_b
# solve を実装する
just t     # サンプル全件テスト
just s     # 提出
```

`just new` は URL だけで、置き場所・ディレクトリ名（公式タイトルのケバブケース）・
`Main.hs` 冒頭の見出し・サンプルの取得まで済ませる。

`just t` / `just s` / `just doc` に引数は要らない。**最後に編集した `Main.hs` のディレクトリ**が
対象になる。引数なしの `just` でレシピ一覧と現在の対象が出る。
明示するなら `just dir=problems/… t`。

コンテストに出るときは `just contest abc268` で全問ぶんをまとめて用意できる
（[atcoder-cli](https://github.com/Tatamo/atcoder-cli) 経由）。

`just doc` は doctest。テンプレートには doctest を入れていないので、自分で切り出した関数を
試したくなったときに `-- >>>` を書く（015 がその例）。ByteString リテラルを使うなら
`-- $setup` に `-- >>> :set -XOverloadedStrings` を足す。

進捗は [AtCoder Problems](https://kenkoooo.com/atcoder) が提出履歴から出してくれるので、
リポジトリ側では管理しない。

## 環境

ジャッジ（[2025/10](https://img.atcoder.jp/file/language-update/2025-10/language-list.html)）は
**GHC 9.8.4** + `cabal v2-build`。手元もそれに合わせてある。

- `cabal.project` / `atcoder-env.cabal` — ジャッジと同じ GHC・パッケージ集合を宣言する。
  中身のない `atcoder-env` パッケージは、`cabal build` に
  `.ghc.environment.*` を書かせるためだけに存在する。これがあると素の `runghc` /
  `doctest` からも `bytestring`・`containers`・`vector`・`ac-library-hs` が見える。
- `pyproject.toml` / `uv.lock` — `online-judge-tools` (`oj`) を固定する。Python 本体ごと
  `uv` が用意するので、グローバルには何も入らない。`oj` は言語非依存で、C++ や Rust の人も使う。

### セットアップ

```sh
ghcup install ghc 9.8.4 && ghcup set ghc 9.8.4
cabal build                                        # 依存の取得と .ghc.environment.* の生成
cabal install doctest --with-compiler=ghc-9.8.4
brew install uv just                               # oj は uv run 経由なので個別導入は不要
npm install -g atcoder-cli                         # just contest を使う場合のみ
just login                                         # 提出・contest 生成に必要
```

### ログイン

AtCoder が reCAPTCHA を導入したため、`acc login` / `oj login` のパスワード認証は通らない
（正しいパスワードでも `login failed` になる）。ブラウザのセッションクッキーを渡す:

1. ブラウザで AtCoder にログインする
2. DevTools → Application → Cookies → `https://atcoder.jp` → `REVEL_SESSION` の値をコピー
3. `just login` を実行して貼り付ける（入力は表示されず、シェル履歴にも残らない）

`just check` で `oj` と `acc` 両方のログイン状態を確認できる。
セッションが切れたら `just login` をやり直す。

### acc のグローバル設定

`acc` のグローバル設定はこのリポジトリを参照しない（`oj` は justfile が PATH を通し、
テンプレートは justfile が配る）。別マシンでは出力先の名前だけ合わせればよい:

```sh
acc config default-test-dirname-format test   # oj t の既定に合わせる
acc config default-task-choice all
```

`ghcup set` を忘れると、GHC のバージョンとファイル名が対応している
`.ghc.environment.*` が読まれず、`bytestring` などが hidden package になる。
