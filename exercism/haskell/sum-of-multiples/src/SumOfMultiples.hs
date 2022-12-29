module SumOfMultiples (sumOfMultiples) where

import Data.List

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = sum $ factor factors [0..limit - 1]

factor :: [Integer] -> [Integer] -> [Integer]
factor [] limitList = []
factor arr limitList = nub $ concatMap (\x -> fd x limitList) arr

fd :: Integer -> [Integer] -> [Integer]
fd 0 _ = []
fd _ [] = []
fd f (x:xs)
    | x `mod` f == 0 = x : fd f xs
    | otherwise = fd f xs