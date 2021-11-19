module Mongolia.PolyAndTypeClasses where

f :: [a] -> (a -> a) -> [a]
f arr f' = map f' arr
