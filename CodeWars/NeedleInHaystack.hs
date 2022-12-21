{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}

module CodeWars.NeedleInHaystack where
    
import Data.List hiding (findIndex)
import Data.Maybe

-- https://www.codewars.com/kata/56676e8fabd2d1ff3000000c/train/haskell

findNeedle :: [String] -> String
findNeedle arr = "found the needle at position " ++ show (findIndex arr "needle" 0)

findIndex :: [String] -> String -> Int -> Int
findIndex [] [] _ = 0
findIndex (x:xs) t i
    | x == t = i
    | otherwise = findIndex xs t i+1

instance Num String where -- never mind this bollocks. it just makes integer literals possibly be strings so I didn't have to type endless quotes.
  fromInteger = show
  (+) = undefined ; (*) = undefined ; abs = undefined ; signum = undefined ; negate = undefined


-- Best solution
-- First get the element by index using elemIndex
-- Returns the value wrapped in the Maybe Monad so we use fromJust to return the matched value and show it to append to the string.
findNeedle2 :: [String] -> String
findNeedle2 arr = ("found the needle at position " ++) $ show $ fromJust $ elemIndex "needle" arr