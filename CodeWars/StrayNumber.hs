module CodeWars.StrayNumber where

import Data.List

stray :: [Int] -> Int
stray [] = 0
stray [x] = x
stray (x:xs)
    | x `elem` xs = stray xs
    | otherwise = x

-- Since im stupid here is an actual solution...why was this so hard

stray2 :: [Int] -> Int
stray2 (x:xs)
  | elem x xs = head $ filter (x /=) xs
  | otherwise = x