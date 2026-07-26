-- 005 - Modulo 100
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_e
-- Status: AC

main :: IO ()
main = do
  _ <- getLine
  a <- map read . words <$> getLine :: IO [Int]
  print $ mod (sum a) 100
