module Mongolia.DataTypesAndFunctions where

-- https://www.youtube.com/watch?v=OnuYmTbj9pk&list=PLJ3w5xyG4JWmBVIigNBytJhvSSfZZzfTm&index=5

addMaybes :: Maybe Int -> Maybe Int -> Maybe Int 
addMaybes (Just x) (Just y) = Just (x + y)
addMaybes _         _       = Nothing

liftMaybe :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
liftMaybe f (Just x) (Just y) = Just(f x y)
liftMaybe _ _        _        = Nothing


-- Pairs
swap :: (a, b) -> (b, a)
swap (a, b) = (b, a)

-- Currying
curry :: ((a, b) -> c) -> (a -> b -> c)
curry f a b = f (a, b)

-- Uncurrying
unCurry :: (a -> b -> c) -> ((a, b) -> c)
unCurry f (a, b) = f a b