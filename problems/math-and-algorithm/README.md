# 「アルゴリズムと数学」演習問題集

[コンテストページ](https://atcoder.jp/contests/math-and-algorithm) — 001〜104。ディレクトリ名は問題番号 + 公式タイトルのケバブケース。

最初に解いた分は [Zenn のスクラップ](https://zenn.dev/kimuracoki/scraps/02dbf610234f98)に書いていたものを、サンドボックスが消えても残るようここへ移した。

Status の "AC" はスクラップに失敗の記録がないことから推定したもので、ジャッジで確認し直したわけではない。013 と 014 は TLE を踏んでいるので `1-tle/` `2-ac/` に試行を分けてある。

<!-- index:start -->
| Problem | Directory | Status |
|---------|-----------|--------|
| [001 - Print 5+N](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_a) | [001-print-5-plus-n](001-print-5-plus-n/Main.hs) | AC |
| [002 - Sum of 3 Integers](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_b) | [002-sum-of-3-integers](002-sum-of-3-integers/Main.hs) | AC |
| [003 - Sum of N Integers](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_c) | [003-sum-of-n-integers](003-sum-of-n-integers/Main.hs) | AC |
| [004 - Product of 3 Integers](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_d) | [004-product-of-3-integers](004-product-of-3-integers/Main.hs) | AC |
| [005 - Modulo 100](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_e) | [005-modulo-100](005-modulo-100/Main.hs) | AC |
| [006 - Print 2N+3](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_f) | [006-print-2n-plus-3](006-print-2n-plus-3/Main.hs) | AC |
| [007 - Number of Multiples 1](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_g) | [007-number-of-multiples-1](007-number-of-multiples-1/Main.hs) | AC |
| [008 - Brute Force 1](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_h) | [008-brute-force-1](008-brute-force-1/Main.hs) | AC |
| [009 - Brute Force 2](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_i) | [009-brute-force-2](009-brute-force-2/Main.hs) | Partial (500 pts) |
| [010 - Factorial](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_j) | [010-factorial](010-factorial/Main.hs) | AC |
| [011 - Print Prime Numbers](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_k) | [011-print-prime-numbers](011-print-prime-numbers/Main.hs) | AC |
| [012 - Primality Test](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_l) | [012-primality-test](012-primality-test/Main.hs) | AC |
| [013 - Divisor Enumeration](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_m) | [013-divisor-enumeration/1-tle](013-divisor-enumeration/1-tle/Main.hs) | TLE |
| [013 - Divisor Enumeration](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_m) | [013-divisor-enumeration/2-ac](013-divisor-enumeration/2-ac/Main.hs) | AC |
| [014 - Factorization](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_n) | [014-factorization/1-tle](014-factorization/1-tle/Main.hs) | TLE |
| [014 - Factorization](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_n) | [014-factorization/2-ac](014-factorization/2-ac/Main.hs) | AC |
| [015 - Calculate GCD](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_o) | [015-calculate-gcd](015-calculate-gcd/Main.hs) | AC |
| [016 - Greatest Common Divisor of N Integers](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_p) | [016-greatest-common-divisor-of-n-integers](016-greatest-common-divisor-of-n-integers/Main.hs) | AC |
| [017 - Least Common Multiple of N Integers](https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_q) | [017-least-common-multiple-of-n-integers](017-least-common-multiple-of-n-integers/Main.hs) | WIP |
<!-- index:end -->

表は `scripts/index.sh` の生成物。直すときは各問題の `README.md` を編集してから再実行する。
