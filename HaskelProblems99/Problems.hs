{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module HaskelProblems99.Problems where

import Data.List
import Data.Ratio

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

-- Input "aaaabccaadeeee"
encodeModified :: String -> [ListItem Char]
encodeModified s = map f (encode'' s)
    where
        f (x, y) = case x of
            1 -> Single y
            _ -> Multiple x y

-- p12

decodeModified :: [ListItem Char] -> String
decodeModified [] = []
decodeModified (x:xs) = case x of
    Single a -> a : decodeModified xs
    Multiple i a -> replicate i a ++ decodeModified xs

-- p13
-- ???

-- p14
dupli :: [a] -> [a]
dupli [] = []
dupli (x:xs) = x : x : dupli xs

-- p15
repli :: [a] -> Int -> [a]
repli [] _ = []
repli (x:xs) n = replicate n x ++ repli xs n

-- p16
dropEvery :: [a] -> Int -> [a]
dropEvery [] _ = []
dropEvery arr n = untup $ filter (\(a, i) -> (i `mod` 3) /= 0) (zip arr [1..])
    where
        untup [] = []
        untup ((a,b):xs) = a : untup xs

-- p17
split :: String -> Int -> (String, String)
split s n = (take n s, drop n s)
-- split s n = splitAt n s

-- p18
slice :: [Char] -> Int -> Int -> String
slice [] _ _ = []
slice arr i k
    | i > 0 = take (k - i + 1) $ drop (i - 1) arr

-- p19
-- Revisit, not working
rotate :: [Char] -> Int -> String
rotate _ 0 = []
rotate (x:xs) n = rotate (xs ++ [x]) n
rotate xs n = rotate xs (length xs + n)

-- p20
-- **** To Review ****
removeAt :: Int -> [a] -> Maybe (a, [a])
removeAt _ [] = Nothing
removeAt n xs = case back of
    [] -> Nothing
    x:rest -> Just (x, front ++ rest)
    where
        (front,back) = splitAt (n - 1) xs

-- p21
