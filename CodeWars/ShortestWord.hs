module ShortestWord where

import Data.List    

find_shortest :: String -> Integer
find_shortest = fromIntegral . minimum . map length . words 