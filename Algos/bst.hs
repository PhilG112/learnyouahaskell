{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Tree where

data Tree t = EmptyTree | Node t (Tree t) (Tree t) deriving (Show, Ord, Eq)

initTree :: a -> Tree a
initTree x = Node x EmptyTree EmptyTree

-- Insert into
insert :: (Ord a) => a -> Tree a -> Tree a
insert x EmptyTree = initTree x
insert x (Node n left right)
    | x == n = Node x left right
    | x < n = Node n (insert x left) right
    | x > n = Node n left (insert x right) 

-- Exists?



-- Find value