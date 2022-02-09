module CodeWars.VowelCount where

getCount :: String -> Int
getCount [] = 0
getCount (x:xs)
    | x `elem` "aeiou" = 1 + getCount xs
    | otherwise = getCount xs

-- getCount :: String -> Int
-- getCount = length . filter (`elem` "aeiou")