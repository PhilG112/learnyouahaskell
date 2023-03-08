module Testing123 where

-- https://www.codewars.com/kata/54bf85e3d5b56c7a05000cf9/train/haskell

number :: [String] -> [String]
number [] = []
number xs =
    map (\(a,as) -> show a ++ ": " ++ as) $ zip [1..] xs
    
-- best solution
number2 :: [String] -> [String]
number2 = zipWith (\ a b -> show a ++ ": " ++ b) [1..]