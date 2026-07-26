-- 003 - Sum of N Integers
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_c
-- Status: AC

main :: IO ()
main = do
  _ <- getLine
  a <- map read . words <$> getLine :: IO [Int]
  print $ sum a
