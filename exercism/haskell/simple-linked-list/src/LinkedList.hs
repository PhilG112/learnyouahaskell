module LinkedList
    ( LinkedList
    , datum
    , fromList
    , isNil
    , new
    , next
    , nil
    , reverseLinkedList
    , toList
    ) where

data LinkedList a = EmptyList | Cons a (LinkedList a) deriving (Eq, Show)

datum :: LinkedList a -> a
datum EmptyList = error "No Datum"
datum (Cons v _) = v

fromList :: [a] -> LinkedList a
fromList [] = EmptyList
fromList (x:xs) = Cons x (fromList xs)

isNil :: LinkedList a -> Bool
isNil EmptyList = True
isNil _ = False

new :: a -> LinkedList a -> LinkedList a
new = Cons

next :: LinkedList a -> LinkedList a
next EmptyList = EmptyList
next (Cons _ xs) = xs

nil :: LinkedList a
nil = EmptyList

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList EmptyList = EmptyList
reverseLinkedList xs = fromList $ reverse $ toList xs

toList :: LinkedList a -> [a]
toList EmptyList = []
toList (Cons x xs) = x : toList xs