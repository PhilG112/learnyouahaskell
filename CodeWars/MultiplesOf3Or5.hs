module CodeWars.MultiplesOf3Or5 where

solution :: Integer -> Integer
solution n
    | n < 0 = 0
    | otherwise = sum [x | x <- [1..n-1], isMultiple x]

isMultiple :: Integer -> Bool
isMultiple n
    | n `mod` 3 == 0 = True
    | n `mod` 5 == 0 = True
    | otherwise = False


-- solution :: Integer -> Integer
-- solution number = sum [n | n <- [1..number - 1], n `mod` 3 == 0 || n `mod` 5 == 0]