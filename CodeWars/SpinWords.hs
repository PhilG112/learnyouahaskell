
module Main where

-- https://www.codewars.com/kata/5264d2b162488dc400000001/train/haskell

main :: IO ()
main = print "Hello World"

spinWords :: String -> String
spinWords [] = []
spinWords s = (unwords . f . words) s
    where
    f [] = []
    f (x:xs)
        | length x >= 5 = reverse x : f xs
        | otherwise = x : f xs