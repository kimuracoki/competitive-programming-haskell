-- 016 - Greatest Common Divisor of N Integers
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_p
-- Status: AC
--
-- スマホでコーディングから提出、このスクラップの投稿までやってみた。

main :: IO ()
main = do
    _ <- getLine
    as <- map read . words <$> getLine :: IO [Int]
    print $ mgcd as

mgcd :: [Int] -> Int
mgcd [] = 0
mgcd (x:xs) = gcd x $ mgcd xs
