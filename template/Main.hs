{-# LANGUAGE OverloadedStrings #-}

import Data.Maybe (fromJust)
import qualified Data.ByteString.Char8 as BS

main :: IO ()
main = undefined
-- 入力:
--   n   <- getInt                                    -- 1 行に整数 1 つ
--   as  <- getInts                                   -- 1 行に整数が複数
--   xss <- map ints . BS.lines <$> BS.getContents    -- 残り全部を行ごとに
-- 出力:
--   print x         putStrLn s        mapM_ print xs        putInts xs

getInt :: IO Int
getInt = readInt <$> BS.getLine

getInts :: IO [Int]
getInts = ints <$> BS.getLine

putInts :: [Int] -> IO ()
putInts = BS.putStrLn . BS.unwords . map (BS.pack . show)

readInt :: BS.ByteString -> Int
readInt = fst . fromJust . BS.readInt

ints :: BS.ByteString -> [Int]
ints = map readInt . BS.words
