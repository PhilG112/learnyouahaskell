module Hackerrank.BirthdayCakeCandles where

-- https://www.hackerrank.com/challenges/birthday-cake-candles/problem?isFullScreen=true

birthdayCakeCandles :: [Int] -> Int
birthdayCakeCandles candles = length [x | x <- candles, x == maximum candles]

birthdayCakeCandles' :: [Int] -> Int
birthdayCakeCandles' candles = do
    let m = maximum candles
    length $ filter (==m) candles


