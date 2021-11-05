{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module ScratchPad2 where


-- BIG WASTE OF TIME AS LISTS IN HASKELL ARE ALREADY LINKED LISTS

data SinglyLinkedList a = EmptyList | Cons a (SinglyLinkedList a) deriving (Eq)

initList :: a -> SinglyLinkedList a
initList a = Cons a EmptyList

-- Get head
getHead :: SinglyLinkedList a -> Maybe a
getHead EmptyList = Nothing
getHead (Cons a _) = Just a

-- Add
add :: a -> SinglyLinkedList a -> SinglyLinkedList a
add _ EmptyList = EmptyList
add v xs = Cons v xs

-- Remove
remove :: (Ord a) => a -> SinglyLinkedList a -> SinglyLinkedList a
remove _ EmptyList = EmptyList
remove n (Cons x xs) = case x of
    n -> 


-- Update

-- Print as List
getAsList :: SinglyLinkedList a -> [a]
getAsList EmptyList = []
getAsList (Cons x xs) = x : getAsList xs
