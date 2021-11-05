module LeetCode.TwoSum where


main :: IO ()
main = print ""

hhh :: (Num a, Ord a) => a -> [a] -> [Int]
hhh num list = sol ls (reverse ls)
    where
    ls = zip list [0..]
    sol [] _ = []
    sol _ [] = []
    sol xs@((x,i):us) ys@((y,j):vs) = ans
        where
        s = x + y
        ans | s == num = [i,j]
            | j <= i = []
            | s < num = sol (dropWhile ((< num) . (+y) . fst) us) ys
            | otherwise = sol xs $ dropWhile ((num <) . (+x) . fst) vs

twoSum2 :: [Int] -> Int -> (Int, Int)
twoSum2 numbers target = head ([
    (x, y) |
    x <- r, -- 0 0 0 1 1 1 2 2 2
    y <- r, -- 0 1 2 0 1 2 0 1 2
    x < y && (numbers !! x) + (numbers !! y) == target])
    where r = [0..length numbers - 1]

t :: [Int] -> [(Int, Int)]
t xs = [(x,y) | x <- r, y <- r] where r = [0..length xs - 1]