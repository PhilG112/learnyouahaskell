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