-- TLE（実行時間制限超過）して通らず……。
--
-- O(n) → O(√n) にしなきゃ。

main :: IO ()
main = do
  n <- readLn :: IO Int
  putStrLn $ unlines $ [show x | x <- [1 .. n], n `mod` x == 0]
