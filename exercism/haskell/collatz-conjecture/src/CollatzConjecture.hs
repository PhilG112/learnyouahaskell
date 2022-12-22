module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
collatz 0 = Nothing
collatz 1 = Just 0
collatz n
    | n > 0 = doSteps n 0
    | otherwise = Nothing

doSteps :: Integer -> Integer -> Maybe Integer
doSteps 1 steps = Just steps
doSteps num steps
    | even num = doSteps (num `div` 2) (steps+1)
    | odd num = doSteps (num * 3 + 1) (steps+1)