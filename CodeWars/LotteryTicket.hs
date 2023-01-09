module LotteryTicket where

-- https://www.codewars.com/kata/57f625992f4d53c24200070e/train/haskell

import Data.Char

bingo :: [(String,Int)] -> Int -> String
bingo [] _ = "Loser!"
bingo lt w = if length (filter miniWin lt) >= w
    then "Winner!"
    else "Loser!"
    
miniWin :: (String, Int) -> Bool
miniWin ([],_) = False
miniWin t = f $ fst t
    where
        n = snd t

        f [] = False
        f (x:xs)
            | ord x == n = True
            | otherwise = f xs

-- Better solution
bingo2 :: [(String,Int)] -> Int -> String
bingo2 xs w
  | l >= w    = "Winner!"
  | otherwise = "Loser!"
  where
    l = length $ filter (\(x, y) -> y `elem` map ord x) xs