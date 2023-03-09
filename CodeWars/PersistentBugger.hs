module PersistentBugger where
import Data.Char (digitToInt)

persistence :: Int -> Int
persistence 0 = 0
persistence n = go n 0
    where
        go :: Int -> Int -> Int
        go n i
            | m < 10 = i
            | otherwise = go m i+1
            where
                m = product $ map digitToInt $ show n

-- best solution

persistence2 :: Int -> Int
persistence2 n =
    if n < 10
        then 0
        else 1 + persistence (product $ map digitToInt $ show n)