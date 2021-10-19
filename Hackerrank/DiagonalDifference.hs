{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Hackerrank.DiagonalDifference where

testMatrix :: [[Int]]
testMatrix = [[1, 2, 3], [4, 5, 6], [9, 8, 9]]

getDiagonal :: [[a]] -> [a]
getDiagonal [] = []
getDiagonal (x:xs) = head x : getDiagonal (map tail xs)

diagDiff :: [Int] -> [Int] -> Int 
diagDiff a1 a2 =  abs $ sum a1 - sum a2