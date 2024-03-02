module CodeWars.Disarium where

import Data.Char

disariumNumber :: Int -> String
disariumNumber n =
    let str = show n
        l = length str
        zipped = zip str [1..l]
        computed = compute zipped
    in if computed == n then "Disarium !!" else "Not !!"

compute :: [(Char, Int)] -> Int
compute = foldr (\ x -> (+) (digitToInt (fst x) ^ snd x)) 0
-- compute xs = foldr (\ x -> (+) (digitToInt (fst x) ^ snd x)) 0 xs
-- compute (x:xs) = (digitToInt (fst x) ^ snd x) + compute xs

-- Better solutions
disariumNumber2 :: Int -> String
disariumNumber2 n = if disarium then "Disarium !!" else "Not !!"
    where
        digits = map digitToInt $ show n
        disarium = n == sum (zipWith (^) digits [1..])