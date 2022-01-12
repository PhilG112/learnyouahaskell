module Main where
import Data.Char (isLetter, toLower)
import Data.List ((\\))

-- https://www.codewars.com/kata/545cedaa9943f7fe7b000048/train/haskell

-- Finish off
main :: IO ()
main = print "Hello world"

isPangram :: String -> Bool
isPangram arr = (null . (['a' .. 'z']\\) . map toLower) arr

isPangram' :: String -> Bool
isPangram' arr = (f . map toLower . filter (isLetter)) arr
    where
        alphabet = ['a'..'z']
        f [] = True
        f (x:xs)
            | x `elem` alphabet = f xs
            | otherwise = False
