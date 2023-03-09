module AlternateCap where
import Data.Char (toUpper, toLower)

-- ???
capitalize :: [Char] -> [[Char]]
capitalize [] = []
capitalize xs = 
    [ zipWith ($) (cycle [toUpper, toLower]) xs
    , zipWith ($) (cycle [toLower, toUpper]) xs]

