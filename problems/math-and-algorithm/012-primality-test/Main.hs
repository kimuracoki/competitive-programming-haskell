-- 012 - Primality Test
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_l
-- Status: AC

main :: IO ()
main = do
  n <- readLn :: IO Int
  putStrLn $ f $ isPrime n

isPrime ::  Int -> Bool
isPrime n
  | n < 2 = False
  | otherwise = all (\d -> n `mod` d /= 0) [2 .. floor $ sqrt (fromIntegral n :: Double)]

f :: Bool -> String
f False = "No"
f True = "Yes"
