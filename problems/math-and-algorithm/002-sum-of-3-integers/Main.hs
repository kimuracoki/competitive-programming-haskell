-- 002 - Sum of 3 Integers
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_b

main :: IO ()
main = do
  a <- map read . words <$> getLine :: IO [Int]
  print $ sum a
