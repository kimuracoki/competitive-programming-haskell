-- またもTLE……
--
-- ちゃんと時間計算できないとダメってことだね

main :: IO ()
main = do
  n <- readLn :: IO Int
  putStrLn $ unwords . map show $ f n $ primeTo n

f :: Int -> [Int] -> [Int]
f 1 _ = []
f n [] = [n]
f n (x:xs)
  | x * x > n = [n]
  | n `mod` x == 0 = x : f (n `div` x) (x:xs)
  | otherwise = f n xs



primeTo :: Int -> [Int]
primeTo n = sieve [2..n]
  where
    sieve [] = []
    sieve (p:xs)
      | p * p > n = p : xs
      | otherwise = p : sieve [x | x <- xs, x `mod` p /= 0]
