{-# LANGUAGE InstanceSigs #-}
module ScratchPad3 where

import Prelude hiding (Monad(..))

data Expr = Val Int | Div Expr Expr

-- Doesnt handle div by 0
eval :: Expr -> Int
eval (Val n) = n
eval (Div x y) = eval x `div` eval y

-- Handles 0, safediv
eval2 :: Expr -> Maybe Int
eval2 (Val n) = Just n
eval2 (Div x y) = case eval2 x of
    Nothing -> Nothing
    Just n -> case eval2 y of
        Nothing -> Nothing
        Just g -> Just (g + n)

eval3 :: Expr -> Maybe Int
eval3 (Val n) = pure n -- Same as Just n, but pure here in the Maybe applicative is Just
eval3 (Div x y) = eval3 x >>= (\m -> eval3 y >>= (\n -> Just $ m `div` n))

eval4 :: Expr -> Maybe Int
eval4 (Val n) = Just n
eval4 (Div x y) = do
    n <- eval4 x
    m <- eval4 y
    Just $ n `div` m


data Tree a = Node (Tree a) a (Tree a) | Leaf

buildTree :: a -> Int -> Tree a
buildTree x i =
    if i <= 0
        then Leaf
        else
            let
                subTree = buildTree x (i-1)
            in
                Node subTree x subTree

labelTree :: Tree a -> Tree (Int, a)
labelTree t = fst (runWithCounter (labelTree' t) 1)

newtype WithCounter a = MkWithCounter { runWithCounter :: Int -> (a, Int) }

-- The above runWithCounter is the same as the below function:
-- runWithCounter ::  WithCounter a -> (Int -> (a, Int))
-- runWIthCounter (MkWithCounter f) = f

labelTree' :: Tree a -> WithCounter (Tree (Int, a))
labelTree' Leaf = returnWithCounter Leaf
labelTree' (Node l x r) =
    labelTree' l >>=
        \l' -> tick >>=
        \labelForX -> labelTree' r >>=
        \r' -> returnWithCounter (Node l' (labelForX, x) r')
    
tick :: WithCounter Int
tick = MkWithCounter (\current -> (current, current +1))

bindWithCounter :: WithCounter a -> (a -> WithCounter b) -> WithCounter b
bindWithCounter computation continuation =
    MkWithCounter (\currentCounter ->
    case runWithCounter computation currentCounter of
        (result, currentCounter') -> runWithCounter (continuation result) currentCounter'
    )

returnWithCounter :: a -> WithCounter a
returnWithCounter x = MkWithCounter (\currentCounter -> (x, currentCounter))

class Monad m where
    return :: a -> m a
    (>>=) :: m a -> (a -> m b ) -> m b

instance Monad WithCounter where
    return :: a -> WithCounter a
    return = returnWithCounter
    (>>=) :: WithCounter a -> (a -> WithCounter b) -> WithCounter b
    (>>=) = bindWithCounter

