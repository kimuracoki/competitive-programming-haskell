-- 006 - Print 2N+3
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_f
-- Status: AC

main :: IO ()
main = do
  n <- readLn :: IO Int
  print $ 2 * n + 3
