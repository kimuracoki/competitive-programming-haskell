-- 011 - Print Prime Numbers
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_k

main :: IO ()
main = do
  n <- readLn :: IO Int
  putStrLn $ unwords . map show $ primeTo n

primeTo :: Int -> [Int]
primeTo n = sieve [2..n]
  where
    sieve [] = []
    sieve (p:xs)
      | p * p > n = p : xs
      | otherwise = p : sieve [x | x <- xs, x `mod` p /= 0]
