-- 013 - Divisor Enumeration
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_m
-- Status: AC
--
-- これで通した。
--
-- √n までの約数を調べたものを a、もう片方の約数 n/x を b とすると、
-- a と b をあわせて n までのすべての約数を満たせている。らしい。
-- 詳しくは書籍にて。

main :: IO ()
main = do
  n <- readLn :: IO Int
  let a = [x | x <- [1 .. floor $ sqrt (fromIntegral n :: Double)], n `mod` x == 0]
  let b = [n `div` x | x <- a, x /= n `div` x]
  mapM_ print $ a ++ b
