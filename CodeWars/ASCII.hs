module CodeWars.ASCII where

import Data.Char

getChar' :: Int -> Char
getChar' = chr

chunksOf :: Int -> [e] -> [[e]]
chunksOf _ [] = []
chunksOf i (x:y:z:xs) = [x,y,z] : chunksOf i xs  