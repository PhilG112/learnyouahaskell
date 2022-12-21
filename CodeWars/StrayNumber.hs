module CodeWars.StrayNumber where

import Data.List

stray :: [Int] -> Int
stray [] = 0
stray [x] = x
stray (x:xs)
    | x `elem` xs = stray xs
    | otherwise = x