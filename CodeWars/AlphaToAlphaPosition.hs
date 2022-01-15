module CodeWars.AlphaToAlphaPosition where
import Data.List
import Data.Char (isLetter, toLower, isAlpha, isAscii)

-- https://www.codewars.com/kata/546f922b54af40e1e90001da/train/haskell

-- alphabetPosition :: String -> String
-- alphabetPosition = unwords .  filter (\x -> (read x>=1) && (read x<27)) . map (f . toLower)
--   where f a =  show (fromEnum a - 96)

alphabetPosition :: String -> String
alphabetPosition [] = []
alphabetPosition arr = unwords $ map (go . toLower) $ filter isLetter (filter isAscii arr)
    where
        alpha = ['a'..'z']
        
        go :: Char -> String
        go s = case elemIndex s alpha of
            Nothing -> ""
            Just v -> show $ v + 1