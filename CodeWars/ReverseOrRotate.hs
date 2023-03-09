module ReverseOrRotate where

import Data.List.Split (chunksOf)
import Data.Char (digitToInt)
import Data.List (intercalate)
-- FAIL
revRot :: [Char] -> Int -> [Char]
revRot [] _ = []
revRot s n
    | n > length s = []
    | n <= 0 = []
    | otherwise = go $ mySplit n xs

sumDivtwo :: String -> Bool
sumDivtwo [] = False
sumDivtwo xs = sum (map ((^3) . digitToInt) xs) `div` 2 == 0

mySplit :: Int -> [a] -> [[a]]
mySplit n [] = []
mySplit n xs = take n xs : mySplit n (drop n xs)

-- Best solution

revRotAux :: [Char] -> [Char]
revRotAux s = res
    where
        r = sumDigitsToCube s
        res = if even r then reverse s else rotate s
        rotate :: String -> String
        rotate sn = tail sn ++ [head sn]
        sumDigitsToCube :: [Char] -> Int
        sumDigitsToCube = sum . map ((^3) . digitToInt)

revRot2 :: [Char] -> Int -> [Char]
revRot2 str sz
    | (sz <= 0) || (str == "") || (sz > length str) = ""
    | otherwise = res
        where
            arr = splitEqual str sz
            res = intercalate "" $ map revRotAux arr
            splitEqual :: [a] -> Int -> [[a]]
            splitEqual s n = takeWhile (\x -> length x == n) $ chunksOf n s