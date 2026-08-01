-- B - Shift only
-- https://atcoder.jp/contests/abc081/tasks/abc081_b

{-# LANGUAGE OverloadedStrings #-}

import Data.Maybe (fromJust)
import qualified Data.ByteString.Char8 as BS

main :: IO ()
main = do
  _ <- getLine 
  as <- getInts
  print $ solve as

solve :: [Int] -> Int 
solve as 
  | all even as = 1 + solve (map ( `div` 2) as)
  | otherwise = 0

getInts :: IO [Int]
getInts = map readInt . BS.words <$> BS.getLine
  where
    readInt = fst . fromJust . BS.readInt
