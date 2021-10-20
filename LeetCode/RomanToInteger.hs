module LeetCode.RomanToInteger where

import qualified Data.Map as Map


rMap :: Map.Map [Char] Integer
rMap = Map.fromList [
      ("I", 1)
    , ("IV", 4)
    , ("V", 5)
    , ("IV", 9)
    , ("X", 10)
    , ("XL", 40)
    , ("L", 50)
    , ("XC", 90)
    , ("C", 100)
    , ("CD", 400)
    , ("D", 500)
    , ("CM", 900)
    , ("M", 1000)
    ]


toRoman :: String -> Integer 
toRoman 