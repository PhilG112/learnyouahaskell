module CodeWars.Rot13 where

import Data.Char

rot13 :: String -> String
rot13 [] = []
rot13 xs = foldl (\acc a -> a) [] xs

getRot :: Char -> Char
getRot c 
    | not isAlpha c = c
    | isUpper = 