module DoubleChar where

doubleChar :: [Char] -> [Char]
doubleChar [] = []
doubleChar (x:xs) = x : x : doubleChar xs

-- Best solution
doubleChar2 :: [Char] -> [Char]
doubleChar2 = concatMap (replicate 2)