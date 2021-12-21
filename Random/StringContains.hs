module Random.StringContains where

type StringToMatch = String

contains :: StringToMatch -> String -> Bool
contains _ [] = False
contains allx@(x:xs) (y:ys)
    | x /= y = contains allx ys
    | x == y = contains xs ys
