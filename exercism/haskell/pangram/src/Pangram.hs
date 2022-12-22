module Pangram (isPangram) where
import Data.Char

isPangram :: String -> Bool
isPangram [] = False
isPangram str = uses (sanitizeInput str)
    where
        uses :: String -> Bool
        uses s = usesLetter s alphabet

usesLetter :: String -> [Char] -> Bool
usesLetter _ [] = True
usesLetter str (x:xs)
    | x `elem` str = usesLetter str xs
    | otherwise = False

alphabet :: [Char]
alphabet = ['a'..'z']

sanitizeInput :: String -> String
sanitizeInput str = filter (`elem` alphabet) $ map toLower str