module Mongolia.Lists where

-- https://www.youtube.com/watch?v=d88RuBaPqNI&list=PLJ3w5xyG4JWmBVIigNBytJhvSSfZZzfTm&index=6

-- data [a] = [] | a : [a]

lol :: [a] -> Int
lol xs = foldr (\ x -> (+) 1) 0 xs

e :: Eq a => a -> [a] -> Bool
e x [] = False
e x (y:ys) = x == y || e x ys
