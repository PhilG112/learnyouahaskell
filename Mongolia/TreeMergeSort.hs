module Mongolia.TreeMergeSort (Tree(..), sort, merge) where

data Tree a = Leaf a | Node (Tree a) (Tree a)

sort :: Ord a => Tree a -> [a]
sort (Leaf x) = [x]
sort (Node l r) = merge (sort l) (sort r)

merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge (x:xs) [] = x:xs
merge (x:xs) (y:ys)
    | x <= y = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys