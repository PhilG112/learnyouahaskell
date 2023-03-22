module TonysBlog where
import Data.Maybe (fromMaybe)
import Control.Monad (liftM)

-- https://blog.tmorris.net/posts/20-intermediate-haskell-exercises/

{-
Fill in the blanks (which are marked error "todo") with a nontrivial implementation that typechecks.
I recommend that you use the run button after implementing each one to make sure that it still typechecks.
Let the types guide you!
If you have trouble implementing a typeclass method, then try writing out the specialized type that it should have.
For example, furry imlpemented for [] should have the type (a -> b) -> [a] -> [b].
-}

class Fluffy f where
  furry :: (a -> b) -> f a -> f b

-- fmap is used to apply a function of type (a -> b) to a value of type f a, where f is a functor,to produce a value of type f b
instance Fluffy [] where
    furry :: (a -> b) -> [a] -> [b]
    furry = map -- or fmap

-- Exercise 2
-- Relative Difficulty: 1
instance Fluffy Maybe where
  furry :: (a -> b) -> Maybe a -> Maybe b
  furry = fmap

-- Exercise 3
-- Relative Difficulty: 5
instance Fluffy ((->) t) where
  furry :: (a -> b) -> (t -> a) -> t -> b
  furry f g t = f $ g t -- or eta reduced to f . g

newtype EitherLeft b a = EitherLeft (Either a b)
newtype EitherRight a b = EitherRight (Either a b)

-- Exercise 4
-- Relative Difficulty: 5
instance Fluffy (EitherLeft t) where
  furry :: (a -> b) -> EitherLeft t a -> EitherLeft t b
  furry f (EitherLeft (Left e)) = EitherLeft (Left (f e))

-- Exercise 5
-- Relative Difficulty: 5
instance Fluffy (EitherRight t) where
  furry :: (a -> b) -> EitherRight t a -> EitherRight t b
  furry f (EitherRight (Right e)) = EitherRight (Right (f e))

class Misty m where
  banana :: (a -> m b) -> m a -> m b
  unicorn :: a -> m a

  -- Exercise 6
  -- Relative Difficulty: 3
  -- (use banana and/or unicorn)
  furry' :: (a -> b) -> m a -> m b
  furry' f m = banana (\v -> unicorn $ f v) m

instance Misty [] where
  banana :: (a -> [b]) -> [a] -> [b]
  banana = concatMap

  unicorn :: a -> [a]
  unicorn a = [a]

-- Exercise 8
-- Relative Difficulty: 2
instance Misty Maybe where
  banana :: (a -> Maybe b) -> Maybe a -> Maybe b
  -- could also be implemented as -> maybe Nothing f m
  banana f m = case m of
    Just x -> f x
    Nothing -> Nothing

  unicorn :: a -> Maybe a
  unicorn = return

instance Misty ((->) t) where
  banana :: (a -> t -> b) -> (t -> a) -> t -> b
  banana f g t = f (g t) t

  unicorn :: a -> t -> a
  unicorn = const

-- Exercise 10
-- Relative Difficulty: 6
instance Misty (EitherLeft t) where
  banana :: (a -> EitherLeft t b) -> EitherLeft t a -> EitherLeft t b
  banana f (EitherLeft (Left v)) = f v

  unicorn :: a -> EitherLeft t a
  unicorn a = EitherLeft (Left a)

-- Exercise 11
-- Relative Difficulty: 6
instance Misty (EitherRight t) where
  banana :: (a -> EitherRight t b) -> EitherRight t a -> EitherRight t b
  banana f (EitherRight (Right v)) = f v

  unicorn :: a -> EitherRight t a
  unicorn a = EitherRight (Right a)

-- Exercise 12 - Look into this furter
-- Relative Difficulty: 3
jellybean :: (Misty m) => m (m a) -> m a
jellybean m = banana id m

-- Exercise 13
-- Relative Difficulty: 6
apple :: (Misty m) => m a -> m (a -> b) -> m b
apple m mm = banana (\f -> furry' f m) mm

-- banana :: (a -> m b) -> m a -> m b
-- furry' :: (a -> b) -> m a -> m b

-- Exercise 14
-- Relative Difficulty: 6
moppy :: (Misty m) => [a] -> (a -> m b) -> m [b]
moppy [] _ = unicorn []
moppy (x:xs) f = banana (\b -> banana (\bs -> unicorn (b:bs)) (moppy xs f)) (f x)

-- Exercise 15
-- Relative Difficulty: 6
-- (bonus: use moppy)
sausage :: (Misty m) => [m a] -> m [a]
sausage [] = unicorn []
sausage (x:xs) =  

-- Exercise 16
-- Relative Difficulty: 6
-- (bonus: use apple + furry')
banana2 :: (Misty m) => (a -> b -> c) -> m a -> m b -> m c
banana2 = error "todo"

-- Exercise 17
-- Relative Difficulty: 6
-- (bonus: use apple + banana2)
banana3 :: (Misty m) => (a -> b -> c -> d) -> m a -> m b -> m c -> m d
banana3 = error "todo"

-- Exercise 18
-- Relative Difficulty: 6
-- (bonus: use apple + banana3)
banana4 :: (Misty m) => (a -> b -> c -> d -> e) -> m a -> m b -> m c -> m d -> m e
banana4 = error "todo"

newtype State s a = State {
  state :: (s -> (s, a))
}

-- Exercise 19
-- Relative Difficulty: 9
instance Fluffy (State s) where
  furry = error "todo"

-- Exercise 20
-- Relative Difficulty: 10
instance Misty (State s) where
  banana = error "todo"
  unicorn = error "todo"