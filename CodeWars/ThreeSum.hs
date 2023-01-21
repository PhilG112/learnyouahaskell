module CodeWars.ThreeSum where

getSum :: Int -> Int -> Int
getSum a b =
    let
        min' = min a b
        max' = max a b
    in
        sum [min'..max']

getSum' :: Int -> Int -> Int
getSum' a b
    | a > b = sum [b..a]
    | otherwise = sum [a..b]