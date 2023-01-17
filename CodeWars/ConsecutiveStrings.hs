module CodeWars.ConsecutiveStrings where

import Data.List.Split (divvy)
import Data.List (maximumBy)
import Data.Ord (comparing)


-- https://www.codewars.com/kata/56a5d994ac971f1ac500003e/train/haskell

-- longestConsec :: [String] -> Int -> String
-- longestConsec [] _ = []
-- longestConsec _ 0 = []
-- longestConsec arr@(x:xs) k = _
--     where
--         intercalated = intercalate "" $ take k arr

longestConsec :: [String] -> Int -> String
longestConsec [] _ = []
longestConsec _ 0 = []
longestConsec arr k
    | k > length arr = []
    | otherwise = longestInList $ groupAndJoin k arr

groupAndJoin :: Int -> [String] -> [String]
groupAndJoin 0 _ = []
groupAndJoin _ [] = []
groupAndJoin n arr@(x:xs) = intercalate "" (take n arr) : groupAndJoin n xs

longestInList :: [String] -> String
longestInList [] = []
longestInList [a] = a
longestInList (x:y:xs)
    | length x > length y = longestInList (x : xs)
    | length x < length y = longestInList (y : xs)
    | otherwise = longestInList (x : xs)

-- Top solution
longestConsec2 :: [String] -> Int -> String
longestConsec2 ss k
  | k <= 0 || k > length ss = ""
  | otherwise = maximumBy (comparing length)
              . reverse . fmap concat
              . divvy k 1 $ ss