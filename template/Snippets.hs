-- | 貼り付け元。ここのものは Main.hs には入れていない。必要になった問題にだけ足す。
--
-- Neovim では同名のスニペットを登録してあるので、`getIntTable` などと打って
-- 補完から展開すれば、このファイルを開かずに挿入できる。
--
-- どれも template/Main.hs の import だけで動くようにしてある（追加の import は不要）。
module Snippets where

import Data.Maybe (fromJust)
import qualified Data.ByteString.Char8 as BS

-- | n 行それぞれに整数が並ぶ。クエリや行列。
--
-- > A_1 B_1
-- > A_2 B_2
getIntTable :: Int -> IO [[Int]]
getIntTable n = sequence (replicate n getInts)

-- | n 行の文字列。グリッド。
--
-- > .#.
-- > ..#
getGrid :: Int -> IO [BS.ByteString]
getGrid n = sequence (replicate n BS.getLine)

-- | 残り全部を行ごとの整数列として読む。行数が入力に書かれていないとき。
getRestTable :: IO [[Int]]
getRestTable = map ints . BS.lines <$> BS.getContents

-- | 空白区切りで 1 行に出力する。
putInts :: [Int] -> IO ()
putInts = BS.putStrLn . BS.unwords . map (BS.pack . show)

-- | @Yes@ / @No@ で答える問題用。
putYesNo :: Bool -> IO ()
putYesNo b = putStrLn (if b then "Yes" else "No")

-- 以下は template/Main.hs にもあるもの。このファイル単体を型検査するために置いてある。

getInts :: IO [Int]
getInts = ints <$> BS.getLine

readInt :: BS.ByteString -> Int
readInt = fst . fromJust . BS.readInt

ints :: BS.ByteString -> [Int]
ints = map readInt . BS.words
