-- A - Five Integers
-- https://atcoder.jp/contests/abc268/tasks/abc268_a

{-# LANGUAGE OverloadedStrings #-}

import Data.Maybe (fromJust)
import qualified Data.ByteString.Char8 as BS

main :: IO ()
main = BS.interact solve

solve :: BS.ByteString -> BS.ByteString
solve = undefined

readInt :: BS.ByteString -> Int
readInt = fst . fromJust . BS.readInt

ints :: BS.ByteString -> [Int]
ints = map readInt . BS.words

showInts :: [Int] -> BS.ByteString
showInts = BS.unwords . map (BS.pack . show)
