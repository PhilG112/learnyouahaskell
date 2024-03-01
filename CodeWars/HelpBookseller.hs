module HelpBookseller where

-- https://www.codewars.com/kata/54dc6f5a224c26032800005c/train/haskell

data Stock    = Stock String Int deriving (Show, Eq)

stocklist :: [Stock] -> [Char] -> [(Char, Int)]
stocklist [] _ = []
stocklist _ [] = []
stocklist xs (y:ys) = (y, countStock xs y) : stocklist xs ys

countStock :: [Stock] -> Char -> Int
countStock [] _ = 0
countStock xs c = sum $ map (f c) xs
    where
        f c (Stock s i) = if head s == c then i else 0

-- best solution:

stocklist2 :: [Stock] -> [Char] -> [(Char, Int)]
stocklist2 _ [] = []
stocklist2 [] _ = []
stocklist2 st cs = map (\x -> (x, quantity st x)) cs

quantity :: [Stock] -> Char -> Int
quantity st x = sum [if x == head c then q else 0 | Stock c q <- st]