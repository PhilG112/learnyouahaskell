module Factorial where

factorial :: Int -> Int
factorial i = product [1..i]

-- Without product

factorial2 0 = 1
factorial2 1 = 1
factorial2 n = n * factorial (n - 1)

-- With foldr

factorial3 n = foldr (*) 1 [1..n]