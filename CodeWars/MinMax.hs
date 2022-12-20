module CodeWars.MinMax where

import Prelude hiding (minimum)

minimum :: [Int] -> Int
minimum [] = 0
minimum [x] = x
minimum (x:xs)
    | x < minimum xs = x
    | otherwise = minimum xs

maximum :: [Int] -> Int
maximum [] = 0
maximum [x] = x
maximum (x:xs)
    | x > minimum xs = x
    | otherwise = minimum xs