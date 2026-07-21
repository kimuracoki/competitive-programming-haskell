-- doctest を導入してみた。
--
-- これでreplしながら、テスト駆動しながら、というリズムで書くことができるはず。

main :: IO ()
main = do
  [a, b] <- map read . words <$> getLine :: IO [Int] 
  putStrLn $ show $ gcd' a b 

-- |
-- >>> gcd' 33 88 
-- 11
-- >>> gcd' 123 777 
-- 3
--
-- prop> gcd' (abs a) (abs b) == gcd a b
gcd' :: Int -> Int -> Int
gcd' a 0 = a
gcd' a b = gcd' b $ a `mod` b
