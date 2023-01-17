module CodeWars.SquareEveryDig where


squareDigit :: Int -> Int
squareDigit i = read $ concatMap (\x -> show (read x * read x)) (split $ show i)
    where
        split :: [Char] -> [Char]
        split [] = []
        split (x:xs) = x : split xs