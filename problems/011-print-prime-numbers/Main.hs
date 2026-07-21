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
