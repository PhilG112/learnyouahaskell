module CodeWars.EqualSidesArray where

import Control.Applicative ((<$>), (<*>))
import Data.List (elemIndex)
import Data.Maybe (fromMaybe)

findEvenIndex :: [Int] -> Int
findEvenIndex = 
    fromMaybe (-1) .
    elemIndex True .
    (zipWith (==) <$> scanl1 (+) <*> scanr1 (+))

findEvenIndex' :: [Int] -> Int
findEvenIndex' [] = 0
findEvenIndex' arr =
    let
        split = splitAt 0 arr
    in 0

helper :: [Int] -> Int -> IO Int
helper [] _ = return $ -1
helper arr i
    | i == length arr = return $ -1
    | otherwise = 
        let
            split = splitAt i arr
            fst' = sum $ init $ fst split
            snd' = sum $ snd split
        in
            if fst' == snd' then return i else helper arr (i+1)

myFunc :: Maybe Int -> Maybe Int -> Maybe Int
myFunc a b = (*) <$> a <*> b