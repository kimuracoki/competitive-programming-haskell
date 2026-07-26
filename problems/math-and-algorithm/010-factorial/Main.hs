-- 010 - Factorial
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_j

main :: IO ()
main = do
  n <- readLn :: IO Int
  print $ factorial n

factorial :: Int -> Int
factorial n = product [1..n]
