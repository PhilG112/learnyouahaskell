module Anagram (anagramsFor) where

import Data.List
import Data.Char

anagramsFor :: String -> [String] -> [String]
anagramsFor [] [] = []
anagramsFor _ [] = []
anagramsFor [] _ = []
anagramsFor word candidates = filter (doWork (map toLower word) . map toLower) candidates

doWork :: String -> String -> Bool
doWork xs ys
    | xs == ys = False
    | sort xs == sort ys = True
    | otherwise = False

