{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE InstanceSigs #-}
module Mongolia.ReaderMonad where
import Control.Monad

-- Either
throwError :: e -> Either e a
throwError = Left

catchError :: Either e a -> (e -> Either e a) -> Either e a
catchError (Right a) _ = Right a
catchError (Left e) h = h e

div' :: Int -> Int -> Either String Int
div' m n
    | n /= 0 = return $ div m n
    | n == 0 = throwError "divison by 0"

divWithDefault :: Int -> Int -> Int -> Either String Int
divWithDefault m n d = do
    catchError (div' m n) (\_ -> return d)

-- given the read only state of type r compute the result of type a
newtype Reader r a = Reader {runReader :: r -> a}

instance Functor (Reader r) where
    fmap = liftM

instance Applicative (Reader r) where
    pure = return
    (<*>) = ap

instance Monad (Reader r) where
    return :: a -> Reader r a
    return a = Reader $ \_ -> a

    (>>=) :: Reader r a -> (a -> Reader r b) -> Reader r b
    m >>= cont = Reader $ \r -> runReader (cont (runReader m r)) r     

-- COntinue video at the 18min mark