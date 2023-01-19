module CodeWars.ArrayDiff where

difference :: Eq a => [a] -> [a] -> [a]
difference [] _ = []
difference (x:xs) b
    | x `elem` b = difference xs b
    | otherwise = x : difference xs b

difference' :: Eq a => [a] -> [a] -> [a]
difference' a b = filter (`notElem` b) a

difference'' :: Eq a => [a] -> [a] -> [a]
difference'' a b = [c | c <- a, c `notElem` b]