module Luhn (isValid) where

import Data.Char (digitToInt, isDigit)

-- Solution

isValid :: String -> Bool
isValid n
    | length (normalize n) < 2 = False
    | not (all (\x -> x == ' ' || isDigit x) n) = False
    | otherwise = luhn (normalize n) `mod` 10 == 0

    where
        normalize = map digitToInt . reverse . filter isDigit

        luhn (x:y:xs) = x + (if y < 5 then 2 * y else 2 * y - 9) + luhn xs
        luhn [x] = x
        luhn [] = 0

-- isValid :: String -> Bool
-- isValid "1" = False
-- isValid "0" = False
-- isValid n =
--     let
--         ints = [digitToInt x | x <- n, not (isSpace x)]
--         seconds = second ints
--         firsts = first ints
--         combined = map determineLuhn seconds ++ firsts
--         sums = sum combined
--     in
--         (sums `rem` 10) == 0

-- determineLuhn :: Int -> Int
-- determineLuhn n =
--     let
--         multiplied = n * 2
--         isGreaterThanNine = multiplied > 9
--     in if isGreaterThanNine
--         then multiplied - 9 else multiplied

-- second :: [Int] -> [Int]
-- second [] = []
-- second [x] = [x]
-- second (x:y:xs) = x : second xs

-- first :: [Int] -> [Int]
-- first [] = []
-- first [_] = []
-- first (x:y:xs) = y : first xs