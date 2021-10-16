{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module BST where

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
exists :: (Ord a) => a -> Tree a -> Bool
exists x EmptyTree = False
exists x (Node n left right)
    | x == n = True
    | x < n = exists x left
    | x > n = exists x right
