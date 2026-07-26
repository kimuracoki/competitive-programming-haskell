-- 009 - Brute Force 2
-- https://atcoder.jp/contests/math-and-algorithm/tasks/math_and_algorithm_i
--
-- 全探索で解いたため、部分点 500。
--
-- 動的計画法でも解くぞ！ あとでね……
-- （元スクラップにも DP 版は投稿されていないので未着手）

main :: IO ()
main = do
  [_, s] <- map read . words <$> getLine :: IO [Int]
  a <- map read . words <$> getLine :: IO [Int]
  putStrLn $ g $ f a s

f :: [Int] -> Int -> Bool
f [] s = s == 0
f (x:xs) s = f xs s || f xs (s - x)

g :: Bool -> String
g True = "Yes"
g False = "No"
