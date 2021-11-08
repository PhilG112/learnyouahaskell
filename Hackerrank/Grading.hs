module Hackerrank.Grading where

-- https://www.hackerrank.com/challenges/grading/problem?isFullScreen=true

grading :: [Int] -> [Int]
grading [] = []
grading (x:xs)
    | x < 38 = x : grading xs
    | (getNextMultiple x) - x < 3 = getNextMultiple x : grading xs
    | otherwise = x : grading xs
    where
    getNextMultiple n
        | isMultipleOfFive n = n
        | otherwise = getNextMultiple $ succ n

isMultipleOfFive :: Int -> Bool 
isMultipleOfFive 0 = False 
isMultipleOfFive n = n `mod` 5 == 0