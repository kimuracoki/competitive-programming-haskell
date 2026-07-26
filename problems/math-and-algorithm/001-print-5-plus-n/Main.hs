-- 001 - Print 5+N
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_a

main :: IO ()
main = do
  n <- readLn :: IO Int
  print $ n + 5
