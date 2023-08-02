{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module ScratchPad2 where

import System.Random

-- BIG WASTE OF TIME AS LISTS IN HASKELL ARE ALREADY LINKED LISTS

data SinglyLinkedList a = EmptyList | Cons a (SinglyLinkedList a) deriving (Eq)

initList :: a -> SinglyLinkedList a
initList a = Cons a EmptyList

-- Get head
getHead :: SinglyLinkedList a -> Maybe a
getHead EmptyList = Nothing
getHead (Cons a _) = Just a

-- Add
add :: a -> SinglyLinkedList a -> SinglyLinkedList a
add _ EmptyList = EmptyList
add v xs = Cons v xs

-- Remove
remove :: (Ord a) => a -> SinglyLinkedList a -> SinglyLinkedList a
remove _ EmptyList = EmptyList
remove n (Cons x xs) = case x of
    n -> _


-- Update

-- Print as List
getAsList :: SinglyLinkedList a -> [a]
getAsList EmptyList = []
getAsList (Cons x xs) = x : getAsList xs


-- Generate a random polynomial of degree k-1 with a constant term of secret
genPolynomial :: RandomGen g => g -> Int -> Integer -> [Integer]
genPolynomial gen k secret = secret : map fst (tail coeffs)
  where
    coeffs = take k $ iterate (\(a, g) -> (randomR (0, 2^256-1) g, snd (random g))) (randomR (0, 2^256-1) gen, gen)

-- Evaluate the polynomial at point x
evalPolynomial :: [Integer] -> Integer -> Integer
evalPolynomial coeffs x = sum $ zipWith (*) coeffs powers
  where
    powers = iterate (*x) 1

-- Generate n shares of the secret using Shamir's algorithm
generateShares :: RandomGen g => g -> Int -> Int -> Integer -> [(Int, Integer)]
generateShares gen k n secret = map (\i -> (i, evalPolynomial coeffs i)) [1..n]
  where
    coeffs = genPolynomial gen k secret

-- Combine k shares to reconstruct the secret
combineShares :: [(Int, Integer)] -> Integer
combineShares shares = sum $ map (\(x, y) -> y * lagrange x xs) shares
  where
    xs = map fst shares
    lagrange x xs = product [(x - xj) `div` (xi - xj) | xi <- xs, xi /= x, let xj = xi]