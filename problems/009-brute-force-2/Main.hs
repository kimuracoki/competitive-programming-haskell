-- 全探索で解いたため、部分点500
--
-- 動的計画法でも解くぞ！
--
-- あとでね……

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
