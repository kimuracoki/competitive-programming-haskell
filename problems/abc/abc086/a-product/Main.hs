-- A - Product
-- https://atcoder.jp/contests/abc086/tasks/abc086_a

{-# LANGUAGE OverloadedStrings #-}

import Data.Maybe (fromJust)
import qualified Data.ByteString.Char8 as BS

main :: IO ()
main = do
  [a, b] <- getInts
  BS.putStrLn $ evenOrOdd $ a * b

evenOrOdd :: Int -> BS.ByteString
evenOrOdd n
  | odd n = "Odd"
  | otherwise = "Even"

getInt :: IO Int
getInt = readInt <$> BS.getLine

getInts :: IO [Int]
getInts = ints <$> BS.getLine

readInt :: BS.ByteString -> Int
readInt = fst . fromJust . BS.readInt

ints :: BS.ByteString -> [Int]
ints = map readInt . BS.words
