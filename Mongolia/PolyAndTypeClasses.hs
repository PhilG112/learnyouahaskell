module Mongolia.PolyAndTypeClasses where

f :: [a] -> (a -> a) -> [a]
f arr f' = map f' arr


f' :: (Int, Int) -> (Int, Int)
f' (n1, n2) = (n2, n1)

f2 :: (Int, Int) -> (Int, Int)
f2 (n1, n2) = (n1 + n2, 0)

f3 :: (Int, Int) -> (Int, Int)
f3 (n1, n2) = (234234, 23423)

mymap :: (a -> b) -> [a] -> [b]
mymap f [] = []
mymap f (x:xs) = f x : mymap f xs