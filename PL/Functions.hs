{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module PL.Functions where
import Distribution.Utils.Generic (safeTail)

greaterThan0 :: (Ord a, Num a) => a -> [Char]
greaterThan0 x =
    if x > 0
    then "Positon"
    else "OK"

-- Pure functions
    -- Cannot modify state
    -- Cannont depend on state
    -- Same input always returns same output

-- Recursion
pow2 :: (Eq t, Num t, Num p) => t -> p
pow2 n =
    if n == 0
    then 1
    else 2 * pow2 (n-1)

repeatString :: (Eq t, Num t) => [Char] -> t -> [Char]
repeatString s n =
    if n == 0
    then ""
    else s ++ repeatString s (n-1)

pow2' :: (Ord t, Num p, Num t) => t -> p
pow2' n = pow2loop n 1 0
pow2loop :: (Ord t, Num p, Num t) => t -> p -> t -> p
pow2loop n x i =
    if i < n
    then pow2loop n (x*2) (i+1)
    else x

-- Lists
    -- All values must be the same
    -- head
    -- tail
    -- null (check if list is empty)

double :: Num a => [a] -> [a]
double nums =
    if null nums
    then []
    else (2 * head nums) : double (tail nums)

double2 :: Num a => [a] -> [a]
double2 xs = map (* 2) xs

removeOdd :: Integral a => [a] -> [a]
removeOdd nums
  | null nums = []
  | even (head nums) = head nums : removeOdd (safeTail nums)
  | otherwise = removeOdd (tail nums)

removeOdd2 :: Integral a => [a] -> [a]
removeOdd2 nums = [x | x <- nums, even x]

-- Tuples
