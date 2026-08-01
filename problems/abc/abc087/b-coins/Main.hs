-- B - Coins
-- https://atcoder.jp/contests/abc087/tasks/abc087_b

import Data.ByteString.Char8 qualified as BS
import Data.Maybe (fromJust)

main :: IO ()
main = do
  a <- getInt
  b <- getInt
  c <- getInt
  x <- getInt
  print $ solve a b c x

solve :: Int -> Int -> Int -> Int -> Int
solve a b c x =
  length
    [ ()
      | i <- [0 .. a],
        j <- [0 .. b],
        k <- [0 .. c],
        500 * i + 100 * j + 50 * k == x
    ]

readInt :: BS.ByteString -> Int
readInt = fst . fromJust . BS.readInt

getInt :: IO Int
getInt = readInt <$> BS.getLine
