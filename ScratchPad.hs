{-# LANGUAGE RecordWildCards #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Main where
import qualified Data.Map as Map
import Distribution.Simple.Utils (xargs)
import GHC.Types (Bool(False))
import GHC.Real (Integral)
import qualified Random.PhoneBook as PB

main :: IO ()
main = print $ findKey "betty" phoneBook

phoneBook :: [([Char], [Char])]
phoneBook =
    [("betty","555-2938")
    ,("bonnie","452-2928")
    ,("patsy","493-2928")
    ,("lucille","205-2928")
    ,("wendy","939-8282")
    ,("penny","853-2492")
    ]

type MyList k v = [(k,v)]

findKey :: (Eq k) => k -> MyList k v -> Maybe v
findKey key [] = Nothing
findKey key ((k,v):xs) = if key == k
                            then Just v
                            else findKey key xs

data LockerState = Taken | Free deriving (Show, Eq)
type Code = String
type LockerMap = Map.Map Int (LockerState, Code)

lockers :: LockerMap
lockers = Map.fromList
    [(100,(Taken,"ZD39I"))
    ,(101,(Free,"JAH3I"))
    ,(103,(Free,"IQSA9"))
    ,(105,(Free,"QOTSA"))
    ,(109,(Taken,"893JJ"))
    ,(110,(Taken,"99292"))
    ]

lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber map =
    case Map.lookup lockerNumber map of
        Nothing            -> Left $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"
        Just (state, code) -> if state /= Taken
                                then Right code
                                else Left $ "Locker " ++ show lockerNumber ++ " is already taken!"


-- Add two numbers
addTwo:: Int -> Int -> Int
addTwo a b = a + b

-- Sum list
sumList :: [Int] -> Int
sumList [] = 0
sumList x = sum x

sumEvenList :: [Int] -> Int
sumEvenList [] = 0
sumEvenList a = sum [x | x <- a, even x]


data Car = Car { company :: String
               , model :: String
               , year :: Int
               } deriving (Show)

tellCar :: Car -> String
tellCar Car{..} = "This " ++ company ++ " " ++ model ++ " was made in " ++ show year


type PhoneNumber = String 
type Name = String 
type PhoneBook = [(Name, PhoneNumber)]

isInPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool 
isInPhoneBook n pn pb = (n, pn) `elem` pb

-- BST

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

singletonTree :: a -> Tree a
singletonTree x = Node x EmptyTree EmptyTree

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singletonTree x -- If tree is empty return tree with single node
treeInsert x (Node a left right) -- if the node has a left and right tree do checks on each node
    | x == a = Node x left right -- if return node with value x with left and right nodes
    | x < a  = Node a (treeInsert x left) right -- if the value is less than the node value, insert that node on the left
    | x > a  = Node a left (treeInsert x right) -- if the value is greater than the node value, insert that node on thr right


treeElem :: (Ord a) => a -> Tree a -> Bool 
treeElem x EmptyTree = False
treeElem x (Node a left right)
    | x == a = True
    | x < a = treeElem x left
    | x > a =  treeElem x right

-- Construct the tree with fold
treeNums :: [Integer]
treeNums = [1,2,3,4,5,6,7,8,9]
createTree :: Tree Integer
createTree = foldr treeInsert EmptyTree treeNums

-- Pig latainize strings

charToString :: Char -> String
charToString c = [c]

piggy :: String -> String 
piggy [] = []
piggy (x:xs) = xs ++ "-" ++ charToString x ++ "ay"


fizzPop :: Int -> String
fizzPop i
    | i `mod` 3 == 0 = "Fizz"
    | i `mod` 5 == 0 = "Pop"
    | otherwise = "Not a multiple of 3 or 5!"
