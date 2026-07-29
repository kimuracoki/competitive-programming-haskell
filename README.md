# competitive-programming-haskell

AtCoder を Haskell で解いた記録。解答は [`problems/`](problems/README.md) に 1 問 1 ディレクトリ。

## 問題を解く

```sh
just new https://atcoder.jp/contests/abc268/tasks/abc268_b
# 解く
just t     # サンプル全件テスト（-O2 + 2 秒制限）
just s     # 提出
```

`just new` は URL だけで、置き場所・ディレクトリ名（公式タイトルのケバブケース）・
`Main.hs` 冒頭の見出し・サンプルの取得まで済ませる。

### 書き方

`main` は **読む → 呼ぶ → 書く** に留め、考える部分は引数を取る純粋関数に切り出す。

```haskell
main :: IO ()
main = do
  [n, k] <- getInts
  as     <- getInts
  print $ solve n k as

-- |
-- >>> solve 3 2 [1,2,3]
-- 5
solve :: Int -> Int -> [Int] -> Int
solve n k as = ...
```

`BS.interact solve` にするとパースが `solve` の中に入り、doctest の引数が生の入力文字列
（`"3 2\n1 2 3\n"`）になる。引数で渡せば `>>> solve 3 2 [1,2,3]` と読める形で書けるし、
`solve` の型を先に書けば HLS が穴を埋めてくれる。ロジックが 1 行で済む A・B 問題なら
切り出さなくてよい。

doctest が拾うのは Haddock コメントの中だけなので、`-- >>>` の上に `-- |` が要る
（無いと `Examples: 0` で黙って通ってしまう）。走らせるのは `just doc`。

入力は常に `ByteString` で受ける。`String` + `read` は N が 10^5 を超えると TLE するが、
その原因はアルゴリズム側の問題に見えてデバッグしにくいので、問題ごとに切り替えない。

[`template/Main.hs`](template/Main.hs) は `main` の 2 行だけ。読み書きのヘルパー
（`getInts` など）も `import` も、Neovim のスニペット
（`~/.config/nvim/snippets/lua/haskell.lua`）が**使った問題にだけ**入れる。
`getInts` を補完するとカーソル位置に名前が入り、同時に末尾へ定義が、先頭へ `import` が生える。
各定義は `readInt` を `where` に閉じ込めてあるので、複数展開しても二重定義にならない。

詰まったら `dbg`（式の途中）/ `dbgM`（`do` の中）で `Debug.Trace` に出す。
`oj` も AtCoder も stderr を見ないので、覗いたまま `just t` も `just s` も通る。

AtCoder は 1 ファイル提出なので、共通モジュールを `import` して共有することはできない。

### 走らせ方

`just t` / `just s` / `just doc` に引数は要らない。**最後に編集した `Main.hs` のディレクトリ**が
対象になる。引数なしの `just` でレシピ一覧と現在の対象が出る。
明示するなら `just dir=problems/… t`。

`just t` はジャッジと同じ `-O2` でコンパイルしてから走らせ、AtCoder と同じ 2 秒で打ち切る。
`runghc` はインタプリタなので 10^8 回ループに 14 秒（コンパイル版は 0.15 秒）かかり、
TLE かどうかが手元で分からなかった。コンパイル自体は 0.1〜0.4 秒で `runghc` の起動より短い。
中間生成物は `.build/` に出るので `problems/` は汚れない。

Neovim からは `<leader>rt`（テスト）/ `<leader>rs`（提出）/ `<leader>rd`（doctest）。

コンテストに出るときは `just contest abc268` で全問ぶんをまとめて用意できる
（[atcoder-cli](https://github.com/Tatamo/atcoder-cli) 経由）。

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
