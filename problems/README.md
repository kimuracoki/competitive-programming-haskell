# Problems

出題元ごとに番号体系が違うので、出題元で分けてある。1 問 1 ディレクトリで、`Main.hs` と
`oj` が落としてきた `test/`（サンプル入出力）が入る。

- `math-and-algorithm/` — 「アルゴリズムと数学」演習問題集 (001–104)。
  最初に解いた分は [Zenn のスクラップ](https://zenn.dev/kimuracoki/scraps/02dbf610234f98)から移した。
- `abc/` — AtCoder Beginner Contest。`abcNNN/<問題ID>-<タイトル>/`

ディレクトリ名は公式タイトルのケバブケース。`Main.hs` の先頭にタイトルと URL、
そのあとにメモ（詰まった点、TLE の原因）を書く。

TLE で解き直した場合は `1-tle/` `2-ac/` と試行ごとに分ける（013, 014 がその形）。

AC/WA の一覧は [AtCoder Problems](https://kenkoooo.com/atcoder) が提出履歴から出してくれるので、ここには持たない。

`Main.hs` の書き方（`main` は読む → 呼ぶ → 書く、ロジックは純粋関数）と、
入出力ヘルパーの入れ方は [`../README.md`](../README.md#書き方)。
