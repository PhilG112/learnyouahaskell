module AbstractionPatterns where

import qualified Data.Map as M
import Prelude hiding (Monad)

newtype Address = MkAddress Int deriving (Eq, Ord, Show)

addressMapping :: M.Map Address Address
addressMapping =
    M.fromList
    [ (MkAddress 3, MkAddress 7)
    , (MkAddress 4, MkAddress 20)
    , (MkAddress 5, MkAddress 3)
    , (MkAddress 7, MkAddress 14)
    , (MkAddress 9, MkAddress 5)
    , (MkAddress 16, MkAddress 9)
    ]

-- This is ugly, is there a way that we don't have to check the Nothing case in each step? Yes, using bind below.
threeHops :: Address -> Maybe String
threeHops address0 = 
    case M.lookup address0 addressMapping of
        Nothing -> Nothing
        Just address1 -> 
            case M.lookup address1 addressMapping of
                Nothing -> Nothing
                Just address2 ->
                    case M.lookup address2 addressMapping of
                        Nothing -> Nothing 
                        Just address3 -> Just (show address3)

-- This is the same as (>>=) bind.
bindMaybe :: Maybe t -> (t -> Maybe a) -> Maybe a
bindMaybe computation continuation =
    case computation of
        Nothing -> Nothing 
        Just result -> continuation result

-- Abstracted version of threeHops
threeHopsBind :: Address -> Maybe String
threeHopsBind address0 = 
    M.lookup address0 addressMapping >>=
        \a1 -> M.lookup a1 addressMapping >>=
            \a2 -> M.lookup a2 addressMapping >>=
                \a3 -> Just $ show a3

-- Using do notation
threeHopsDo :: Address -> Maybe String
threeHopsDo a0 = do
    a1 <- M.lookup a0 addressMapping
    a2 <- M.lookup a1 addressMapping
    a3 <- M.lookup a2 addressMapping
    (Just . show) a3

-- --------------------------------------------------

data Tree a = Node (Tree a) a (Tree a) | Leaf deriving Show 

buildTree :: a -> Int -> Tree a
buildTree x 0 = Leaf
buildTree x h = Node (buildTree x (h-1)) x (buildTree x (h-1))

-- Refactoring this below
-- labelTree :: Tree a -> Tree (Int, a)
-- labelTree t = fst $ labelTree' t 1

-- v0
-- labelTree' :: Tree a -> Int -> (Tree (Int, a), Int)
-- labelTree' Leaf i = (Leaf, i)
-- labelTree' (Node l x r) i =
--     case labelTree' l i of
--         (l', i') ->
--             let
--                 labelForX = i'
--                 nextLabel = i' + 1
--             in
--                 case labelTree' r nextLabel of
--                     (r', i'') ->
--                         (Node l' (labelForX, x) r', i'')

newtype WithCounter a = MkWithCounter { runWithCounter :: Int -> (a, Int) }

labelTree :: Tree a -> Tree (Int, a)
labelTree t = fst $ runWithCounter (labelTree' t) 1

-- v1
-- labelTree' :: Tree a -> WithCounter (Tree (Int, a))
-- labelTree' Leaf = MkWithCounter (\currentLabel -> (Leaf, currentLabel))
-- labelTree' (Node l x r) =
--     MkWithCounter (\currentLabel -> 
--         case runWithCounter (labelTree' l) currentLabel of
--             (l', currentLabel') ->
--                 case runWithCounter tick currentLabel' of
--                     (labelForX, nextLabel) ->
--                         case runWithCounter (labelTree' r) nextLabel of
--                             (r', currentLabel'') ->
--                                 (Node l' (labelForX, x) r', currentLabel'')
--     )

-- v2
labelTree' :: Tree a -> WithCounter (Tree (Int, a))
labelTree' Leaf = returnWithCounter Leaf
labelTree' (Node l x r) =
    labelTree' l `bindWithCounter` \l' -> -- Label left subtree and return result l'
    tick `bindWithCounter` \labelForX -> -- tick the counter and store that in the result labelForX
    labelTree' r `bindWithCounter` \r' -> -- Label the right subtree and and store that in the result r'
    returnWithCounter (Node l' (labelForX, x) r') -- return the node with everything labeled


tick :: WithCounter Int 
tick = MkWithCounter (\current -> (current, current +1))

-- ONCE AGAIN WE END UP WITH BIND (>>=)
bindWithCounter :: WithCounter a -> (a -> WithCounter b) -> WithCounter b
bindWithCounter computation continuation =
    MkWithCounter (\currentCounter ->
        case runWithCounter computation currentCounter of
            (result, currentCounter') -> runWithCounter (continuation result) currentCounter'
    )

returnWithCounter :: a -> WithCounter a
returnWithCounter x = MkWithCounter (\currentCounter -> (x, currentCounter))
