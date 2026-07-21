main :: IO ()
main = do
  [n, x, y] <- map read . words <$> getLine :: IO [Int]
  print $ length [() | z <- [1..n], z `mod` x == 0 || z `mod` y == 0]
