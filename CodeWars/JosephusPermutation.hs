module JosephusPermutation where

josephus :: [a] -> Int -> [a]
josephus [] _ = []
josephus ls k =
    let
        (x:xs) = drop (k - 1) $ cycle ls
    in
        x : josephus (take (length ls - 1) xs) k
