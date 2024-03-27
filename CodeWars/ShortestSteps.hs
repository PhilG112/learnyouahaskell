module ShortestSteps where

-- https://www.codewars.com/kata/5cd4aec6abc7260028dcd942/train/haskell

steps :: Int -> Int
steps 1 = 0
steps n =
     if even n then
       1 + steps (n `div` 2)
     else
       1 + steps (n - 1)

