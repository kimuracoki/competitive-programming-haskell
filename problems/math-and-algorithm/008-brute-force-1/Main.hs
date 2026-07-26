-- 008 - Brute Force 1
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_h
-- Status: AC

main :: IO ()
main = do
  [n, s] <- map read . words <$> getLine :: IO [Int]
  print $ length [() | x <- [1..n], y <- [1..n], x + y <= s]
