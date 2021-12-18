module Mongolia.Reader where
import Control.Monad.Reader

-- class Functor f where
--     fmap :: (a -> b) -> f a -> f b

-- class Functor f => Applicative f where
--     pure :: a -> f a
--     (<*>) :: f (a -> b) -> f a -> f b

-- class Applicative m => Monad m where
--     return :: a -> m a
--     (>>=) :: m a -> (a -> m b ) -> m b

-- data Either a b = Left a | Right b

throwError :: e -> Either e a
throwError = Left

catchError :: Either e a -> (e -> Either e a ) -> Either e a
catchError (Right a) _ = Right a
catchError (Left e) h = h e

div' :: Int -> Int -> Either String Int
div' m n 
    | n /= 0 = return $ div m n
    | otherwise = throwError "Cannot divide by 0"

divWithDefault :: Int -> Int -> Int -> Either String Int
divWithDefault m n d = do
    -- f arg1 arg2 | arg2 here is the handler
    catchError (div' m n) (\_ -> return d)

-- Given the read only state R compute the result type a
-- newType Reader r a = Reader { runReader :: r -> a }

-- instance Monad (Reader r) where
--     return :: a -> Reader r a
--     return a = Reader $ const a
--     (>>=) :: Reader r a -> (a -> Reader r b) -> Reader r b
--     m >>= cont = Reader $ \r -> runReader (cont (runReadder m r)) r

-- ask :: Reader r r
-- ask = Reader $ \r -> r -- Reader id

-- local :: (r -> r) -> Reader r a -> Reader r a
-- local f m = Reader $ \r -> runReader m (f r)

-- data Config = ...
-- f1 :: Config -> a -> b -> ...
-- f2 :: Config -> c -> ...
-- f3 :: Config -> d -> e -> ...
data Config = Config
    { cfgDecimals :: Int
    } deriving Show

round' :: Double -> Reader Config Double
round' x = do
    cfg <- ask
    let o = cfgDecimals cfg
    let m = 10 ^ cfgDecimals cfg :: Double
    return $ fromIntegral (round (x * m) :: Int) / m

showDouble :: Double -> Reader Config String
showDouble x = fmap show (round' x) -- show <$> round' x

showPi :: Reader Config String
showPi = ("" ++) <$> showDouble pi

showPiDouble :: Reader Config String
showPiDouble = local f showPi
    where
        f :: Config -> Config
        f cfg = cfg { cfgDecimals= 2 * cfgDecimals cfg}


data MyData = MyData
    { someValue :: String
    } deriving Show

appendToVal :: String -> Reader MyData String
appendToVal s = do
    d <- ask
    return $ s ++ someValue d

doAppend :: String -> Reader MyData String
doAppend s = fmap show (appendToVal s)