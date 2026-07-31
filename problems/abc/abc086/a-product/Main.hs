-- A - Product
-- https://atcoder.jp/contests/abc086/tasks/abc086_a

{-# LANGUAGE OverloadedStrings #-}

import Data.Maybe (fromJust)
import qualified Data.ByteString.Char8 as BS

main :: IO ()
main = do
  [a, b] <- getInts
  BS.putStrLn $
    if odd $ a*b then "Odd" else "Even"

getInts :: IO [Int]
getInts = map readInt . BS.words <$> BS.getLine
  where
    readInt = fst . fromJust . BS.readInt
