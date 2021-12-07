module Hackerrank.SockMerchance where

-- https://www.hackerrank.com/challenges/sock-merchant/problem?isFullScreen=true


sockMerchant :: Int -> [Int] -> Int
sockMerchant _ [] = 0
sockMerchant n (x:xs) = case sm x xs of
    0 -> sockMerchant n xs
    v -> 1 + sockMerchant n (removeFirstItem v xs)

removeFirstItem :: Int -> [Int] -> [Int]
removeFirstItem _ [] = []
removeFirstItem n (x:xs)
    | x == n = xs
    | otherwise = x : removeFirstItem n xs

sm :: Int -> [Int] -> Int
sm _ [] = 0
sm current (y:ys)
    | current == y = y
    | otherwise = sm current ys