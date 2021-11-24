module Mongolia.HigherOrderFunctions2 where

import Prelude hiding (flip)

-- https://www.youtube.com/watch?v=4wJ7DzOEDRY&list=PLJ3w5xyG4JWmBVIigNBytJhvSSfZZzfTm&index=12

-- A funciton parameterized by another function or returning a function is called a higher order funciton

-- Function composition
-- (.) :: (b -> c) -> (a -> b) -> (a -> c)
-- (f . g) x = f (g x)

-- Compute the first 100 odd square numbers
example :: [Int]
example = (take 100 . filter odd . map (\x -> x * x)) [1..]

-- Flipping a function
-- If you want to change the order of arguments of  two argument curreid fucntion, you can use:
flip :: (a -> b -> c) -> (b -> a -> c)
flip f x y = f y x

foreach :: [a] -> (a -> b) -> [b]
foreach = flip map

example2 :: [Integer]
example2 = foreach [1,2,3,4] (\x -> x * x)

-- Capturing design patterns
-- Lets abstract
fun :: [a] -> Int
fun [] = 0
fun (x:xs) = fun xs

-- This is actually foldr
fun2 :: (a -> r -> r) -> r -> [a] -> r
fun2 cons nil [] = nil
fun2 cons nil (x:xs) = cons x (fun2 cons nil xs)