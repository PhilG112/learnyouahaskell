module Grains (square, total) where

square :: Integer -> Maybe Integer
square n
    | n < 1     = Nothing
    | n > 64    = Nothing
    | otherwise = Just $ go n 1 1
    where
        go :: Integer -> Integer -> Integer -> Integer
        go initial count r
            | initial == 1 = 1
            | count == initial = r
            | otherwise = go initial (count+1) (r*2)

total :: Integer
total = sum (take 64 (iterate (*2) 1))

-- Other solution
-- ((take 64 (iterate (*2) 1)) !! (fromIntegral (n - 1) :: Int))
