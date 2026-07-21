main :: IO ()
main = do
  [n, s] <- map read . words <$> getLine :: IO [Int]
  print $ length [() | x <- [1..n], y <- [1..n], x + y <= s]
