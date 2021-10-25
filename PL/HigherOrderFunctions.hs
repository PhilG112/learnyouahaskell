module PL.HigherOrderFunctions where

-- Functions as values
    -- FUnctions that accept functions as arguments are higher order

compose :: (t1 -> t2) -> (t3 -> t1) -> t3 -> t2
compose f g x = f (g x)

-- Partial application

foo :: Num a => a -> a -> a -> a
foo x y z = x + y + z

foo_1_2 :: Integer -> Integer
foo_1_2 = foo 1 2

-- foo_1_2 3