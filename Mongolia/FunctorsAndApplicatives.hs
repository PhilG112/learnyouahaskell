{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE DeriveFunctor #-}
module Mongolia.FunctorsAndApplicatives where


-- Compose is a functor
newtype Compose f g a = Compose { getCompose :: f (g a) }
    deriving Show

instance (Functor f, Functor g) => Functor (Compose f g) where
    fmap :: (a -> b) -> Compose f g a -> Compose f g b
    fmap h (Compose fga) = Compose $ fmap (fmap h) fga

instance (Applicative f, Applicative g) => Applicative (Compose f g) where
    pure :: a -> Compose f g a
    pure = Compose . pure . pure

    (<*>) :: Compose f g (a -> b) -> Compose f g a -> Compose f g b
    Compose h <*> Compose a = Compose $ pure (<*>) <*> h <*> a

data Tree a = Leaf a | Node (Tree a) (Tree a)
    deriving (Functor, Show)

-- Using the above example:
    -- toUpper <$> Compose [Leaf 'x', Node (Leaf 'y') (Leaf 'z')]
-- Because List an Tree are both functors you can fmap over the composition of lists and trees

-- What about applicatives?
