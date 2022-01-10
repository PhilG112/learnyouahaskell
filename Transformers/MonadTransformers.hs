module Transformers.MonadTransformers where
import Data.Char
import Control.Monad.Cont
import Control.Monad.State

-- Monad transformers just a way to combine the functionality of two monads IO + Maybe = IOMaybe

type IOMaybe a = IO (Maybe a)

returnIOM :: a -> IOMaybe a
returnIOM = return . Just

bindIOM :: IOMaybe a -> (a -> IOMaybe b) -> IOMaybe b
bindIOM iom f = do
    maybeVal <- iom
    case maybeVal of
        Nothing -> return Nothing
        Just v -> f v

(>>>=) :: IOMaybe a -> (a -> IOMaybe b) -> IOMaybe b
(>>>=) v f = bindIOM v f

liftIOM :: IO a -> IOMaybe a
liftIOM io = io >>= \v -> returnIOM v


checkInput :: String -> Bool
checkInput [] = False
checkInput (x:_) = isUpper x

getName :: IOMaybe String
getName = do
    input <- getLine
    if checkInput input then returnIOM input else return Nothing

example :: IO (Maybe ())
example = putStr "What is your name: "
        >> getName
        >>>= \s -> liftIOM $ putStrLn $ "Your name is " ++ s

-- How to make the above generic/abstract to combine any two monads? This is where the power of monad transformers come in

-- Monad transforms end in a capital T and have a field runSomethingT that exposes the monad
newtype MaybeT m a = MaybeT { runMaybeT :: m (Maybe a) }

instance (Monad m) => Monad (MaybeT m) where
    return a = (MaybeT . return . Just) a

    x >>= f = MaybeT $ do
        v <- runMaybeT x -- returns a Maybe v
        case v of -- We do a case analysis on the result of runMaybeT x
            Nothing -> return Nothing
            Just y -> runMaybeT (f y)

-- How do we lift other monads into our new context? Using MonadTrans we implement a lifting function that lifts other monads into our new context.
instance MonadTrans MaybeT where
    lift = MaybeT . liftM Just -- liftM here is the same as fmap (functorial mapping on monads)

getName' :: MaybeT IO string
getName' = do
    input <- lift getLine
    guard (checkInput input)
    return input

example' = runMaybeT $ do
    lift $ putStr "What is your name "
    name <- getName'
    lift $ putStrLn $ "Your name is " ++ name


-- State transformer (how to keep track of a state?)

-- Read the user input until it is equal to ending. What happens if we want to keep track of how many times the user has guessed?
readUntil :: String -> IO ()
readUntil ending = do
    input <- getLine
    if input == ending then return () else readUntil ending

-- Naive approach, increment a counter and pass that as a parameter
-- One problem is what if we want to keep track of many different states and variables? Do we keep adding new parameters?
-- Second, what if we want to return something else in the IO monad?
readUntilWithCount :: String -> IO Int
readUntilWithCount ending = aux ending 0
    where
        aux :: String -> Int -> IO Int
        aux ending count = do
            input <- getLine
            let ncount = count + 1
            if input == ending then return ncount else aux ending ncount

-- https://hackage.haskell.org/package/transformers-0.6.0.2/docs/Control-Monad-Trans-State-Lazy.html#t:StateT
-- The state transformer keeps track of the output of the computation and the state (<Output>, <State>) in this tuple.

-- Evaluate a state computation with the given initial state and return the final state, discarding the final value.
-- execStateT :: Monad m => StateT s m a -> s -> m s 

readUntilWithState :: String -> IO Int
readUntilWithState ending = execStateT (aux ending) 0
    where
        aux ending = do
            count <- get -- get the state out of the StateT monad
            input <- liftIO getLine -- liftIO the getLine function into the state monad, without liftIO the types are not correct
            put (count + 1) -- Update the state with put
            if input == ending then return () else aux ending
