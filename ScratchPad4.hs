module ScratchPad4 (User (..), dummyUser, dummyUsers, SortBy (Age, Name),) where
import Data.Time
import Data.List
import Data.Maybe (fromMaybe)

data SortBy = Age | Name

data User = User {
    name :: String,
    age :: Int,
    email :: String,
    registrationDate :: Day
} deriving (Eq, Show, Ord)

dummyUsers :: [User]
dummyUsers =
  [ User "Isaac Newton"    372 "isaac@newton.co.uk" (fromGregorian 1683  3 1)
  , User "Albert Einstein" 136 "ae@mc2.org"         (fromGregorian 1905 12 1)
  ]


dummyUser :: User
dummyUser =
    User "Albert Einstein" 136 "ae@mc2.org" (fromGregorian 1905 12 1)

users :: Maybe SortBy -> [User]
users Nothing = dummyUsers
users (Just s) = case s of
    Age -> sortOn age dummyUsers
    Name -> sortOn name dummyUsers

-- Define the data type for a binary search tree
data BST a = Empty | Node a (BST a) (BST a)
  deriving (Show)

-- Helper function to get the height of a tree
height :: BST a -> Int
height Empty = 0
height (Node _ left right) = 1 + max (height left) (height right)

-- Helper function to balance a binary search tree
balance :: [a] -> BST a
balance [] = Empty
balance xs = Node mid (balance left) (balance right)
  where
    -- Find the middle element
    (left, mid:right) = splitAt (length xs `div` 2) xs

-- Main function to balance a binary search tree
balanceBST :: Ord a => BST a -> BST a
balanceBST tree = balance (inorder tree)
  where
    -- Helper function to get the inorder traversal of a tree
    inorder Empty = []
    inorder (Node x left right) = inorder left ++ [x] ++ inorder right