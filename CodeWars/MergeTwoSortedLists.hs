module MergeTwoSortedLists where

data ListNode = Node Int ListNode | Leaf deriving (Show, Eq)

mergeTwoLists :: ListNode -> ListNode -> ListNode
mergeTwoLists Leaf l2 = l2
mergeTwoLists l1 Leaf = l1
mergeTwoLists l1@(Node val1 next1) l2@(Node val2 next2)
    | val1 <= val2 = Node val1 (mergeTwoLists next1 l2)
    | otherwise = Node val2 (mergeTwoLists l1 next2)

fromList :: [Int] -> ListNode
fromList [] = Leaf
fromList (x : xs) = Node x (fromList xs)