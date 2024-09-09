module CodeWars.HighestScoringWord where

import Data.Char (ord)
import Data.Function (on)
import Data.List (maximumBy)

-- https://www.codewars.com/kata/57eb8fcdf670e99d9b000272/train/haskell

high :: String -> String
high str = fst $ getHighest $ map (\x -> (x, getWordScore x)) $ words str

getWordScore :: String -> Int
getWordScore s = countScore s
  where
    countScore :: String -> Int
    countScore [] = 0
    countScore (x : xs) = (countScore xs) + (snd $ head $ filter (\c -> fst c == x) charMap)

charMap :: [(Char, Int)]
charMap = zip ['a' .. 'z'] [1 .. 26]

getHighest :: [(String, Int)] -> (String, Int)
getHighest [x] = x
getHighest (x : y : xs)
    | snd x > snd y = getHighest $ x : xs
    | otherwise = getHighest $ y : xs

-- Top answer
-- how does it work?

high2 :: String -> String
high2 = maximumBy (on compare $ sum . map (subtract 96 . ord)) . reverse . words
