module CodeWars.SimplEncryption where

import Data.List (partition, transpose)

encrypt :: String -> Int -> String
encrypt [] _ = []
encrypt xs n
    | n > 0 = encrypt (getSegment odd xs ++ getSegment even xs) (n-1)
    | otherwise = xs

decrypt :: String -> Int -> String
decrypt [] _ = []
decrypt xs n
    | n > 0 = decrypt (combine evens odds) (n-1)
    | otherwise = xs
    where
        odds = take (length xs `div` 2) xs
        evens = drop (length xs `div` 2) xs

combine :: [a] -> [a] -> [a]
combine [] _ = []
combine _ [] = []
combine (e:es) (o:os) = [e,o] ++ combine es os

getSegment :: (Int -> Bool) -> [a] -> [a]
getSegment _ [] = []
getSegment f xs = map snd $ filter (\(a,_) -> f a) $ zip [0..length xs] xs

-- Best solution
encrypt2 :: String -> Int -> String
encrypt2 s n 
  | n > 0 = iterate go s !! n
  | otherwise = s
  where
    go = map snd . uncurry (++) . partition (odd . fst) . zip [0..]
    
decrypt2 :: String -> Int -> String
decrypt2 s n 
  | n > 0 = iterate go s !! n
  | otherwise = s
  where
    l = length s
    go s = concat $ transpose [drop (l `div` 2) s, take (l `div` 2) s]  