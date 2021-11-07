module Hackerrank.Staircase where

import Data.List

staircase :: Int -> [String]
staircase n = foldl (\ss i -> take n (replicate i ' ' ++ repeat '#'): ss) [] [0..(n - 1)] 


test :: Int -> String
test n = foldl (\x y -> x ++ y) "test" ["a", "b", "c"]