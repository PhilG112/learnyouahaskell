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

-- Map function
    -- Apply function to every element in the list

-- Filter
    -- Creates new list based on a predicate

-- Fold
    -- Combines all values in a list
    -- Two versions
        -- foldr (The accumulator argument is the right argument)
        -- foldl (The accumulator argument is the left argument)

-- Lambda expression
    -- Use sparingly

-- Function operators
    -- (.) Function composition applied right to left. Remember that functions being composed like this must have the same amount of arguments
    -- ($) Function application