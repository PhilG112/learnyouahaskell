module CountDigits where

import Data.Char

nbDig :: Int -> Int -> Int
nbDig n d = sum [length $ filter (==c) $ show (x*x) | x <- [0..n]]
    where c = intToDigit d


