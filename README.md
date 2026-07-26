# competitive-programming-haskell

AtCoder を Haskell で解いた記録。解答は [`problems/`](problems/README.md) に出題元ごと・1 問 1 ディレクトリで置いてある。
新しい問題を解き始めるときの手順も [`problems/README.md`](problems/README.md) にある。

```sh
scripts/new.sh <path> <url>   # 問題ディレクトリ一式を作る
scripts/test.sh <path>        # サンプルと doctest を回す
scripts/index.sh              # 出題元ごとの一覧表を再生成する
```

cabal/stack プロジェクトにはしていない。1 問 1 ファイルで完結させ、`runghc Main.hs` で動かすため。
そのぶん使えるのは GHC 同梱のパッケージ（`containers`, `array`, `bytestring`, `mtl`）だけで、
`vector` や `ac-library-hs` が要る問題に当たったらプロジェクト化から考える。

`scripts/test.sh` が使う [doctest](https://hackage.haskell.org/package/doctest) だけ別途必要:

```sh
cabal install doctest
```
