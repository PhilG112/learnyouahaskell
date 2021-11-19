{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module HaskelProblems99.Problems where

import Data.List

-- p1
getLast :: [a] -> a
getLast arr = last arr

-- p2
butLast :: [a] -> a
butLast arr = arr !! (length arr - 2)

-- p3
elementAt :: [a] -> Int -> a
elementAt arr n = arr !! n

-- p4
myLength :: [a] -> Int
myLength arr = length arr

-- p5
myReverse :: [a] -> [a]
myReverse arr = reverse arr

-- p6
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome arr = reverse arr == arr

-- p7
data NestedList a = Elem a | List [NestedList a]

flatten :: NestedList a -> [a]
flatten (Elem a) = [a]
flatten (List x) = concatMap flatten x

-- p8
compress :: String -> String
compress s = nub s

compress' :: String -> String
compress' s = map head $ group s

-- p9
pack :: String -> [[Char]]
pack [] = []
pack (x:xs) =
    let (first, rest) = span (==x) xs
    in (x:first) : pack rest

-- p10
encode :: String -> [(Int, Char)]
encode s = zipper (pack s)
    where
        zipper [] = []
        zipper (x:xs) = (length x, head x) : zipper xs

encode' :: String -> [(Int, Char)]
encode' xs = [(length x, head x) | x <- group xs]

encode'' :: String -> [(Int, Char)]
encode'' xs = map (\x -> (length x, head x)) $ group xs

-- p11
data ListItem a = Single a | Multiple Int a deriving (Show)
