module Fun where

data MyType a = Nil | Value a

instance Functor MyType where
    fmap :: (a -> b) -> MyType a -> MyType b
    fmap f (Value a) = Value (f a)
    fmap _ Nil = Nil

instance Applicative MyType where
    pure :: a -> MyType a
    pure a = Value a

    (<*>) :: MyType (a -> b) -> MyType a -> MyType b
    (Value f) <*> (Value a) = Value (f a)
    Nil <*> _ = Nil
    _ <*> Nil = Nil

instance Monad MyType where
    (>>=) :: MyType a -> (a -> MyType b) -> MyType b
    Nil >>= _ = Nil
    (Value a) >>= f = f a

    return :: a -> MyType a
    return = pure