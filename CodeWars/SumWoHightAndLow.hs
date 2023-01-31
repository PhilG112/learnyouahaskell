module CodeWars.SumWoHightAndLow where

import Data.List
import Data.Maybe

sumArray :: Maybe [Int] -> Int
sumArray (Just xs) = sum $ tail $ init $ sort xs
sumArray _ = 0

sumArray2 :: Maybe [Int] -> Int
sumArray2 (Just xs@(_:_:_)) = sum xs - maximum xs - minimum xs
sumArray2 _ = 0