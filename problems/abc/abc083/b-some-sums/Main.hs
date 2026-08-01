-- B - Some Sums
-- https://atcoder.jp/contests/abc083/tasks/abc083_b

import Data.ByteString.Char8 qualified as BS
import Data.Char (digitToInt)
import Data.Maybe (fromJust)

main :: IO ()
main = do
  [n, a, b] <- getInts
  print $ solve n a b

solve :: Int -> Int -> Int -> Int
solve n a b =
  sum [x | x <- [1 .. n], ok x]
  where
    ok x = a <= s && s <= b
      where
        s = digitSum x

digitSum :: Int -> Int
digitSum = sum . map digitToInt . show

readInt :: BS.ByteString -> Int
readInt = fst . fromJust . BS.readInt

ints :: BS.ByteString -> [Int]
ints = map readInt . BS.words

getInts :: IO [Int]
getInts = ints <$> BS.getLine
