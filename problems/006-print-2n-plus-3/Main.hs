main :: IO ()
main = do
  n <- readLn :: IO Int
  print $ 2 * n + 3
