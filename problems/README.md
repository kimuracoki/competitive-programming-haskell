# Problems

出題元ごとに番号体系が違うので、まず出題元で分ける。

| 出題元 | 一覧 |
|--------|------|
| 「アルゴリズムと数学」演習問題集 (001–104) | [math-and-algorithm/](math-and-algorithm/README.md) |
| AtCoder Beginner Contest | [abc/](abc/README.md) |

## 1 問あたりのファイル

```
<problem>/
├── README.md     問題の URL・制約・振り返り
├── Main.hs       提出するコードそのもの
├── sample1.in    サンプル入力
└── sample1.out   サンプル出力
```

どこに何を書くかは固定する。混ぜると、後から「制約なんだっけ」を探す場所がブレる。

| 情報 | 置き場所 |
|------|----------|
| 問題 URL、制約、詰まった点・TLE の原因 | `README.md` |
| 提出するコード、その意図を説明するコメント、doctest (`>>>`) | `Main.hs` |
| サンプルの入出力 | `sampleN.in` / `sampleN.out` |
| 進捗一覧 | 出題元の `README.md`（`scripts/index.sh` の生成物。手で書かない） |

`Main.hs` には URL も制約も書かない。提出時にそのまま貼れる状態を保つため。

TLE などで解き直した場合は、試行ごとに `1-tle/Main.hs` `2-ac/Main.hs` と枝を切る（013, 014 がその形）。
サンプルは問題ディレクトリ側に 1 組だけ置けばよく、`scripts/test.sh` は親も見に行く。

## 新しい問題を解くとき

**1. ディレクトリを作る**

```sh
scripts/new.sh abc/abc268/b-counting-nines https://atcoder.jp/contests/abc268/tasks/abc268_b
```

タイトルは URL から取ってくるので、パスの末尾は公式タイトルのケバブケースに合わせる。
`README.md` / `Main.hs` / 空の `sample1.in` / `sample1.out` ができる。

**2. 問題文から 2 か所へコピーする**

- **制約** → `README.md` の「制約」。ここを埋めてから書き始める。
  `N ≤ 10^18` なら `Int` の上限（約 9.2 × 10^18）に収まるか、
  `N ≤ 2×10^5` なら `getLine` + `read` で間に合うか `ByteString` が要るか、
  の判断がここで決まる。後から気づくと TLE / オーバーフローで踏む。
- **サンプル** → `sample1.in` / `sample1.out`。複数あれば `sample2.*` と増やす。

**3. `Main.hs` の `solve` を書く**

入出力から独立した部分を `solve` に切り出しておくと doctest で回せる。
テンプレにはその形が入っている。型は問題に合わせて変えてよい。

**4. テストする**

```sh
scripts/test.sh abc/abc268/b-counting-nines
```

`sampleN.in` を食わせて `sampleN.out` と diff し、`Main.hs` に `>>>` があれば doctest も実行する。

**5. 提出したら Status とメモを書く**

`README.md` の `- Status:` を `AC` などに変え、詰まった点を「メモ」に残してから:

```sh
scripts/index.sh
```

出題元の一覧表が更新される。
