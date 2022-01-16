module CodeWars.OldMobilePhone where
import Data.Char (toLower, isAlpha, isAlphaNum)
import Data.Maybe (fromJust)
import Data.List

groups = ["1", "abc2", "def3", "ghi4", "jkl5", "mno6", "pqrs7", "tuv8", "wxyz9", "*", " 0", "#"]

presses :: String -> Int
presses [] = 0
presses arr = presses' $ map toLower $ filter (\x -> isAlphaNum x || x == ' ') arr

presses' :: String -> Int
presses' [] = 0
presses' (x:xs) = getIndex groups x + presses' xs
-- presses' xs = foldr ((+) . getIndex groups) 0 xs

getIndex :: [String] -> Char -> Int
getIndex [] _ = 0
getIndex (x:xs) c
    | c `elem` x = 1 + fromJust (elemIndex c x)
    | otherwise = getIndex xs c