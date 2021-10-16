-- https://www.hackerrank.com/challenges/fp-filter-array/problem?h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen

module Hackerrank.FilterArray where


f :: Int -> [Int] -> [Int]
f n [] = []
f n arr = filter (< n) arr

-- The Input/Output section. You do not need to change or modify this part
main :: IO ()
main = do 
    n <- readLn :: IO Int 
    inputdata <- getContents 
    let 
        numbers = map read (lines inputdata) :: [Int] 
    putStrLn . unlines $ (map show . f n) numbers