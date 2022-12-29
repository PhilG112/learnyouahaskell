module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance xs ys
    | length xs /= length ys = Nothing
    | otherwise = Just $ doWork xs ys

doWork :: String -> String -> Int
doWork [] [] = 0
doWork _ [] = 0
doWork [] _ = 0
doWork (x:xs) (y:ys)
    | x /= y = 1 + doWork xs ys
    | otherwise = doWork xs ys