-- B - Card Game for Two
-- https://atcoder.jp/contests/abc088/tasks/abc088_b

import Data.ByteString.Char8 qualified as BS
import Data.List (sortOn)
import Data.Maybe (fromJust)
import Data.Ord (Down (Down))

main :: IO ()
main = do
  _ <- getInt
  as <- getInts
  print $ solve as

solve :: [Int] -> Int
solve as = sum es - sum os
  where
    (es, os) = splitindex $ sortOn Down as

splitindex :: [Int] -> ([Int], [Int])
splitindex [] = ([], [])
splitindex (x : y : xs) = (x : evens, y : odds)
  where
    (evens, odds) = splitindex xs
splitindex [x] = ([x], [])

readInt :: BS.ByteString -> Int
readInt = fst . fromJust . BS.readInt

getInt :: IO Int
getInt = readInt <$> BS.getLine

ints :: BS.ByteString -> [Int]
ints = map readInt . BS.words

getInts :: IO [Int]
getInts = ints <$> BS.getLine
