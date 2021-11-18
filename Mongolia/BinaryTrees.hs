module Mongolia.BinaryTrees where

data Tree a = Leaf a | Node (Tree a) (Tree a)

flatten :: Tree a -> [a]
flatten (Leaf a) = [a]
flatten (Node left right) = flatten left ++ flatten right

height :: Tree a -> Int 
height (Leaf x) = 0
height (Node l r) = 1 + max (height l) (height r)