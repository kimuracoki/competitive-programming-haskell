-- 014 - Factorization
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_n
--
-- これで通した。

main :: IO ()
main = do
  n <- readLn :: IO Int
  let factors = primeFactors n
  putStrLn $ unwords (map show factors)

primeFactors :: Int -> [Int]
primeFactors n = go n 2
  where
    go m d
      | m == 1      = []
      | d * d > m   = [m]                      
      | m `mod` d == 0 = d : go (m `div` d) d  
      | d == 2      = go m 3                   
      | otherwise   = go m (d + 2)             
