main :: IO ()
main = do
  n <- readLn :: IO Int
  print $ factorial n

factorial :: Int -> Int
factorial n = product [1..n]
