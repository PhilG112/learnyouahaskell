module NonConsecutiveNumber where

import Data.List

firstNonConsecutive :: (Eq a, Enum a, Ord a) => [a] -> Maybe a
firstNonConsecutive [] = Nothing
firstNonConsecutive (x:y:xs)
    | succ x /= y = Just y
    | otherwise = firstNonConsecutive (y:xs)
