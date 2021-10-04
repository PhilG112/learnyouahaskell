module Main where

import Data.List (union)
import GHC.Real (Integral)

main :: IO ()
main = print "Hello"

-- 1
-- https://projecteuler.net/problem=1
-- multOf3and5 = sum (takeWhile (< 1000) ([3,6..999] `union` takeWhile (< 1000) ([5,10..999]))


p1 :: Integer
p1 = sum (union [3, 6..999] [5,10..999])

-- 2
-- https://projecteuler.net/problem=2

p2 :: Integer
p2 = sum [x | x <- takeWhile (<= 4000000) fibs, even x]
    where
        fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

-- 3
-- https://projecteuler.net/problem=3

primes :: [Integer]
primes = 2 : filter (null . tail . primeFactors) [3,5..]

primeFactors :: Integer -> [Integer]
primeFactors num = factor num primes
    where 
        factor num (listHead:listTail)
            | listHead * listHead > num = [num]
            | num `mod` listHead == 0 = listHead : factor (num `div` listHead) (listHead:listTail)
            | otherwise = factor num listTail

p3 :: Integer
p3 = last (primeFactors 600851475143)

-- 4
{-
A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

Find the largest palindrome made from the product of two 3-digit numbers.
-}

-- numList :: [Integer]
-- numList = [100,101..999]

-- isPalindrome :: Eq a => [a] -> Bool
-- isPalindrome w = w == reverse w

-- p4_v1 :: Integer 
-- p4_v1 = checkPali numList
--     where
--         checkPali (x:y:xs)
--             | isPalindrome $ words (show x * y) = 3

p4 :: Integer
p4 = maximum [
    x | z <- [100..999]
    , y <- [100..999]
    , let x = y * z
    , let s = show x
    , s == reverse s
    ]

-- 5

{-
2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
-}

p5 :: Integer 
p5 = foldr1 lcm [1..20]


-- 6
{-
The sum of the squares of the first ten natural numbers is, 1^2 + 2^2 + ... + 10^2 = 385

The square of the sum of the first ten natural numbers is, (1 + 2 + ... + 10)^2 = 55^2 = 3025

Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 - 385 = 2640

Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
-}

sumSquares :: Integer
sumSquares = sum (map (^2) [1..100])

sumAllSquares :: Integer
sumAllSquares = (sum [1..100]) ^ 2
-- OR
p6 :: Integer
p6 = (sum [1..100]) ^ 2 - sum (map (^2) [1..100])

-- 7

p7 :: Integer
p7 = primes !! 10000