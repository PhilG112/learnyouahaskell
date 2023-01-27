module MergeSortMergeFunction where

merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge a@(x:xs) b@(y:ys)
  | x < y     = x : merge xs b
  | otherwise = y : merge a ys
