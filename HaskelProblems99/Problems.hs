{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module HaskelProblems99.Problems where

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
myReverse (x:xs) = myReverse ([xs] ++ [x])

-- p6
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome arr = reverse arr == arr

-- p7
data NestedList a = Elem a | List [NestedList a]

flatten :: NestedList a -> [a]
flatten (Elem a) = []
flatten (List (x:xs)) = [x] ++ flatten List 