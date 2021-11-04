module PL.Monads where



-- IO
-- Any pure value can be turned into an IO value with return function
-- Cannot reverse, IO values cannot be turned into pure values

-- List is a monad
-- flatMap :: [a] -> (a -> [b]) -> [b]
-- flatMap [1,7,11] (\x -> [x, x+1])
-- [1,2,7,8,11,12]

-- Maybe is a monad
-- bindMaybe :: Maybe a -> (a -> Maybe b) -> Maybe B
-- bindMaybe (Just 0) (\x -> if (x==0) then Nothing else Just (2*x))

-- Common functionality for monads
-- Monad type classes

-- class Monad m where -- The type m is a monad
--     return :: a -> m a -- Return takes a value and wraps it up in the monad type m
--     (>>=) :: m a -> (a -> m b) -> m b -- Bind operation, same as bind functions above

join :: Monad m => m (m a) -> m a
join mmx = mmx >>= id

-- do Notation
addM :: Monad m => m Int -> m Int -> m Int 
addM mx my =
    -- mx is passed to the bind operator and its inner value is bound in the lambda  to the argument x
    -- Same thing with my
    -- Added as normal ints then packaged back up into a monad using the return function
    mx >>= (\x -> my >>= (\y -> return (x + y)))

addDoM :: Monad m => m Int -> m Int -> m Int
addDoM mx my = do
    x <- mx -- Values on the right of <- are monadic values and are unpacked and bound to the variable on the left of the <-
    y <- my
    return (x + y)

people :: [[Char]]
people = ["Alice", "Bob", "Eve"]

items :: [[Char]]
items = ["Car", "Puppy"]


missing :: [[Char]]
missing = do
    person <- people
    item <- items
    return (person ++ " lost a " ++ item)
