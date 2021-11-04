module PL.MonadicFunctions where
import Control.Monad (filterM, foldM)

-- Lifting
    -- liftM :: Monad m => (a -> b) -> (m a -> m b)
    -- liftM (1+) (Just 3)
    -- liftM2 (+) (Just 3) (Just 5)
    -- lift (+)
    -- Simple do notation can be replaced with liftM if all you are doing is unpacking passing to a function and repacking values

-- Monadic List functions
    -- mapM :: Monad m => (a -> m b) -> [a] -> m [b]
    -- forM :: Monad m => [a] -> (a -> m b) -> m [b]
    -- filterM :: Monad m => (a -> m Bool) -> [a] -> m [a]

askToKeep :: Int -> IO Bool 
askToKeep x = do
    putStrLn ("keep" ++ (show x) ++ "?")
    (c:_) <- getLine
    return (c == 'y')

askWhichToKeep :: [Int] -> IO [Int]
askWhichToKeep xs = filterM askToKeep xs

    -- foldM :: Monad m => (a -> b -> m a ) -> a -> [b] -> m a
sayAddition :: Int -> Int -> IO Int
sayAddition x y = do
    let z = x + y
    putStrLn ((show x) ++ " + " ++
              (show y) ++ " = " ++
              (show z))
    return z

talkingSum :: [Int] -> IO Int
talkingSum xs = foldM sayAddition 0 xs
