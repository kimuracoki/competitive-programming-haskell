-- A - Placing Marbles
-- https://atcoder.jp/contests/abc081/tasks/abc081_a

{-# LANGUAGE OverloadedStrings #-}

import Data.Maybe (fromJust)
import qualified Data.ByteString.Char8 as BS
import Data.Bool (bool)

main :: IO ()
main = do
  n <- getInt
  putYesNo  

getInt :: IO Int
getInt = readInt <$> BS.getLine
  where
    readInt = fst . fromJust . BS.readInt

putYesNo :: Bool -> IO ()
putYesNo = putStrLn . yn

yn :: Bool -> String
yn = bool "No" "Yes"
