-- 007 - Number of Multiples 1
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_g
-- Status: AC

main :: IO ()
main = do
  [n, x, y] <- map read . words <$> getLine :: IO [Int]
  print $ length [() | z <- [1..n], z `mod` x == 0 || z `mod` y == 0]
