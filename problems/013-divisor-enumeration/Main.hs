-- 以下で通した。
--
-- √nまでの約数を調べたものをa
--
-- もう片方の約数n/xをb
--
-- aとbをあわせてnまでのすべての約数を満たせている。らしい。
--
-- 詳しくは書籍にて。

main :: IO ()
main = do
  n <- readLn :: IO Int
  let a = [x | x <- [1 .. floor $ sqrt (fromIntegral n :: Double)], n `mod` x == 0]
  let b = [n `div` x | x <- a, x /= n `div` x]
  mapM_ print $ a ++ b
