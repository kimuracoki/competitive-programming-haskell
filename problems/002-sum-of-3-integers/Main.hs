main :: IO ()
main = do
  a <- map read . words <$> getLine :: IO [Int]
  print $ sum a
