module OrderPlease where
import Data.Char
import Data.List (sortBy, sortOn, find)

-- https://www.codewars.com/kata/55c45be3b2079eccff00010f/train/haskell

yourOrderPlease :: String -> String
yourOrderPlease [] = []
yourOrderPlease xs = unwords $ map snd $ sortBy (\(a,_) (b,_) -> compare a b) $ map getNum $ words xs

getNum :: String -> (Int, String)
getNum s = (read $ filter isDigit s :: Int, s)

-- Best solution
yourOrderPlease2 :: String -> String
yourOrderPlease2 = unwords . sortOn (find isDigit) . words