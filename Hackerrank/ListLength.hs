module Hackerrank.ListLength where


len :: [a] -> Int 
len [] = 0
len (_:xs) = 1 + len xs 