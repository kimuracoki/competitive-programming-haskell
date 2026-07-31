-- A - Placing Marbles
-- https://atcoder.jp/contests/abc081/tasks/abc081_a

{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Char8 as BS

main :: IO ()
main = do
  s <- BS.getLine 
  print $ BS.count '1' s
