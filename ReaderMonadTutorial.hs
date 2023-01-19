{-# LANGUAGE InstanceSigs #-}
module ReaderMonadTutorial where

import Control.Monad

throwError :: e -> Either e a
throwError = Left

catchError :: Either e a -> (e -> Either e a ) -> Either e a
catchError (Right a) _ = Right a
catchError (Left e) h = h e

div' :: Int -> Int -> Either String Int
div' m n
    | n /= 0 = return $ m `div` n
    | otherwise = throwError "divsion by zero!"

divWithDefault :: Int -> Int -> Int -> Either String Int
divWithDefault m n d = do
    catchError (div' m n) (const $ return d)

-- Given the readonly state r, compute the result a
newtype Reader r a = Reader { runReader :: r -> a }

instance Functor (Reader r) where
    fmap :: (a -> b) -> Reader r a -> Reader r b
    fmap = liftM

instance Applicative (Reader r) where
    pure :: a -> Reader r a
    pure = return
    
    (<*>) :: Reader r (a -> b) -> Reader r a -> Reader r b
    -- https://hackage.haskell.org/package/base-4.17.0.0/docs/Control-Monad.html#v:ap
    (<*>) = ap

instance Monad (Reader r) where
    return :: a -> Reader r a
    return a = Reader (const a)
    -- OR: return = pure

    (>>=) :: Reader r a -> (a -> Reader r b) -> Reader r b
    m >>= f = Reader $ \r -> runReader (f (runReader m r)) r

ask :: Reader r r
ask = Reader $ \r -> r
-- OR: Reader id

local :: (r -> r) -> Reader r a -> Reader r a
local f m = Reader $ \r -> runReader m (f r)
-- OR: Reader $ runReader m . f

data Config = Config
    { cfgDecimals :: Int
    } deriving Show

round' :: Double -> Reader Config Double
round' x = do
    cfg <- ask
    let m = 10 ^ cfgDecimals cfg :: Double
    return $ fromIntegral (round (x * m) :: Int) / m

showDouble :: Double -> Reader Config String
-- Don't forget we can use <$> here because it is an instance of Functor
-- See the definition above
showDouble x = show <$> round' x

showPi :: Reader Config String
showPi = ("some String" ++) <$> showDouble pi

-- Globally cfgDecimals is 2 but locally here it is modified
showPiDouble :: Reader Config String
showPiDouble = local f showPi
    where
        f cfg = cfg {cfgDecimals = 2 * cfgDecimals cfg}

ff :: [a] -> [a]
ff = foldr (\e acc -> acc ++ [e]) []