module Mongolia.FoldlAndFoldr where

-- Capturing design patterns
-- Lets abstract
fun :: [a] -> Int
fun [] = 0
fun (x:xs) = fun xs

-- This is actually foldr
fun2 :: (a -> r -> r) -> r -> [a] -> r
fun2 cons nil [] = nil
fun2 cons nil (x:xs) = cons x (fun2 cons nil xs)

length :: Integer
length = foldr (\_ r -> r + 1) 0 [1,2,3]

foldr' :: (a -> r -> r) -> r -> [a] -> r
foldr' cons nil = go
    where
        go [] = nil
        go (x:xs) = cons x (go xs)

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter p = foldr (\x r -> if p x then x : r else r) []

myMap :: (a -> b) -> [a] -> [b]
myMap f = foldr (\x r -> f x : r) []

myAnd :: [Bool] -> Bool
myAnd = foldr (&&) True

myAny :: (a -> Bool) -> [a] -> Bool
myAny f arr = foldr (\x r -> f x || r) False arr

s :: Num a => [a] -> a
s = go 0
    where
        go :: Num a => a -> [a] -> a
        go acc [] = acc
        go acc (x:xs) = go (x + acc) xs

-- Lets abstract s (fun3 is actually foldl)
fun3 :: (r -> a -> r) -> r -> [a] -> r
fun3 op e = go e
    where
        go acc [] = acc
        go acc (x:xs) = go (op acc x) xs

-- foldr (+) 0 [1,2,3] = 1 + (2 + (3 + 0))
-- foldl (+) 0 [1,2,3] = ((0 + 1) + 2) + 3 

-- foldr and foldl will creat space leaks on large lists due to a large number of thunks being created, thus a space leak will be created. We need to enforce strictness. for tthat we use seq. Howver you can use bang pattern (!) instead of infixing seq. 99.99% of the time use the bang pattern when doing any sort of accumulation

data Tree a = Leaf a | Node (Tree a) (Tree a)

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree f (Leaf x) = Leaf (f x)
mapTree f (Node l r) = Node (mapTree f l) (mapTree f r)


-- FUNCTORS

class Functor f where
    fmap :: (a -> b) -> f a -> f b