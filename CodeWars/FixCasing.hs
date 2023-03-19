module FixCasing where

import Data.Char

solve :: String -> String
solve [] = []
solve xs
    | getCount isLower xs > getCount isUpper xs = map toUpper xs
    | otherwise = map toLower xs

getCount :: (a -> Bool) -> [a] -> Int
getCount f xs = length $ filter f xs