module CodeWars.SelectiveArrayReverse where

-- import Data.List.Split (chunksOf)

-- https://www.codewars.com/kata/58f6000bc0ec6451960000fd/train/haskell

selReverse :: Int -> [a] -> [a]
selReverse l xs = concatMap reverse (chunkBy l xs)

-- Very slow
chunkBy :: Int -> [a] -> [[a]]
chunkBy _ [] = []
chunkBy n xs =
    let (ys, zs) = splitAt n xs
    in ys : chunkBy n zs

-- Better chunkby implementation
chunkBy' :: Int -> [a] -> [[a]]
chunkBy' _ [] = []
chunkBy' n xs = go xs []
    where
        go :: [a] -> [[a]] -> [[a]]
        go [] acc = reverse acc
        go ys acc =
            let (chunk, rest) = splitAt n ys
            in go rest (chunk : acc)

-- Top solution
-- selReverse :: Int -> [a] -> [a]
-- selReverse 0 [] = id
-- selReverse n xs = concatMap reverse (chunksOf n xs)