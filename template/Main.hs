{-# LANGUAGE OverloadedStrings #-}

import Data.Maybe (fromJust)
import qualified Data.ByteString.Char8 as BS

main :: IO ()
main = undefined
-- 入力の読み方:
--   n      <- readInt <$> BS.getLine                   -- 1 行に整数 1 つ
--   [a, b] <- ints <$> BS.getLine                      -- 1 行に整数が複数
--   as     <- ints <$> BS.getLine                      -- 同上、個数が可変
--   xss    <- map ints . BS.lines <$> BS.getContents   -- 残り全部を行ごとに

readInt :: BS.ByteString -> Int
readInt = fst . fromJust . BS.readInt

ints :: BS.ByteString -> [Int]
ints = map readInt . BS.words

showInts :: [Int] -> BS.ByteString
showInts = BS.unwords . map (BS.pack . show)
