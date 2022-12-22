module Bob (responseFor) where

import Data.List ( isSuffixOf )
import Data.Char ( isAlpha, isUpper, isSpace )

responseFor :: String -> String
responseFor str
    | null str || all isSpace str = "Fine. Be that way!"
    | isQuestion str && isYelling str = "Calm down, I know what I'm doing!"
    | isQuestion str = "Sure."
    | isYelling str = "Whoa, chill out!"
    | otherwise = "Whatever."

isQuestion :: String -> Bool
isQuestion [] = False
isQuestion str = "?" `isSuffixOf` trim str

isYelling :: String -> Bool
isYelling str = isValidInput str && length (filter isUpper $ sanatizeInput str) == length (sanatizeInput str)

sanatizeInput :: String -> String
sanatizeInput = filter isAlpha

isValidInput :: String -> Bool
isValidInput str = length (filter (\c -> isAlpha  c) str) > 0

trim :: String -> String
trim = f . f
   where f = reverse . dropWhile isSpace