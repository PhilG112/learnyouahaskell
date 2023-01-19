module CodeWars.Longest where

import Data.List

longest :: [Char] -> [Char] -> [Char]
longest s1 s2 = 
    let
        s1' = sort $ nub s1
        s2' = sort $ nub s2
    in
        if length s1' > length s2' then s1' else s2