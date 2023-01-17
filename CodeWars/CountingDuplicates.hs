module CodeWars.CountingDuplicates where
import Data.Char
import Data.List

duplicateCount :: String -> Int
duplicateCount [] = 0
duplicateCount s = dup (map toLower s) 0
    where
        dup :: String -> Int -> Int
        dup [] _ = 0
        dup (x:xs) n
            | existsIn x xs = dup (removeAllOccurrences x xs) n+1
            | otherwise = dup xs n


existsIn :: Eq a => a -> [a] -> Bool
existsIn _ [] = False
existsIn a arr = a `elem` arr

removeAllOccurrences :: Eq a => a -> [a] -> [a]
removeAllOccurrences _ [] = []
removeAllOccurrences v arr =  filter (/= v) arr

-- Top Solution
duplicateCount2 :: String -> Int
duplicateCount2 = length . filter ((> 1) . length) . group . sort . map toLower