-- 004 - Product of 3 Integers
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_d
-- Status: AC

main :: IO ()
main = do
  a <- map read . words <$> getLine :: IO [Int]
  print $ product a
