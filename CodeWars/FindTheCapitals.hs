module CodeWars.FindTheCapitals where
import Data.Char
import Data.List
import Data.Maybe

-- https://www.codewars.com/kata/539ee3b6757843632d00026b/train/haskell

-- First failed solution doesnt account for two of the same characters e.g "AA"
capitals :: String -> [Int]
capitals [] = []
capitals str = cap str str
    where
        cap :: String -> String -> [Int]
        cap _ [] = []
        cap [] _ = []
        cap original (x:xs)
            | isUpper x = fromJust (elemIndex x original) : cap original xs
            | otherwise = cap original xs

-- Working solution
capitals2 :: String -> [Int]
capitals2 [] = []
capitals2 str = cap 0 str
    where
        cap :: Int -> String -> [Int]
        cap _ [] = []
        cap count (x:xs)
            | isUpper x = count : cap (count+1) xs
            | otherwise = cap (count+1) xs

-- Best solution
-- Turns out there is a funciton for this

capitals3 :: String -> [Int]
capitals3 str = findIndices isUpper str