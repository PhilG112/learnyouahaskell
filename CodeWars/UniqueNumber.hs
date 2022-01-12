module CodeWars.UniqueNumber where

import Data.List

getUnique :: [Int] -> Int
getUnique [] = 0
getUnique arr = head $ head $ filter (\x -> length x == 1) $ group $ sort arr

-- getUnique :: [Int] -> Int
-- getUnique (x:xs)
--   | x `elem` xs = getUnique $ filter (/=x) xs
--   | otherwise = x