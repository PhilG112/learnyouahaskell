module Main where
import Control.Monad
import Data.Char


-- VIDEO: https://www.youtube.com/watch?v=hiYPetQ70gw&list=PLJ3w5xyG4JWmBVIigNBytJhvSSfZZzfTm&index=16

main :: IO ()
main = putStrLn "Hello World"

-- (>>) :: IO a -> IO b -> IO b
-- Execute IO a, throw away the result, execute IO B then return IO B

getTwoLines :: IO String
getTwoLines = getLine >> getLine

-- liftM :: (a -> b) -> IO a -> IO b
-- Takes a function and a plan. Constructs a plan that executes the given plan, but before returning the result, applies the function.
-- Same as fmap function

duplicateLine :: IO String
duplicateLine = fmap (\x -> x ++ x) getLine

-- Shouting
-- Apply the function to the IO action. The value contained within the monad?
shout :: IO String
shout = fmap (map toUpper) getLine

-- liftM2 :: (a -> b -> c) -> IO a -> IO b -> IO c
-- Takes an operator and two plans. Constructs a plan that executes the two plans in sequence, and uses the operator to combine the two results.

joinTwoLines :: IO String
joinTwoLines = liftM2 (++) getLine getLine

flipTwoLines :: IO String
flipTwoLines = liftM2 (flip (++)) getLine getLine

-- BIND
-- (>>=) :: IO a -> (a -> IO b) -> IO b
-- Transform the shout function to shout back
shoutBack :: IO ()
shoutBack = shout >>= (\s -> putStrLn s)
--          shout >>= putStrLn < this is called an eta reduction, lambda is not needed for \x -> f x

-- shoutBack in do notation
shoutBackDo :: IO ()
shoutBackDo = do
    s <- shout
    putStrLn s

shoutBackTwice :: IO ()
shoutBackTwice = shout >>= (\s -> putStrLn s >> putStrLn s)

-- A larger example
greeting :: IO ()
greeting =
    putStrLn "What is your name?" >>
    getLine >>= \name ->
    putStrLn ("Hello, " ++ name ++ "!") >>
    putStrLn "Where do you live?" >>
    getLine >>= \location ->
    let
        answer
            | location == "Mongolica" = "M"
            | location == "Mexico" = "O"
            | otherwise = "??"
    in
        putStrLn answer

greetingDo :: IO ()
greetingDo = do
    putStrLn "What is your name"
    name <- getLine
    putStrLn ("Hello, " ++ name ++ "!")
    putStrLn "Where do you live?"
    location <- getLine
    let answer
            | location == "Mongolica" = "M"
            | location == "Mexico" = "O"
            | otherwise = "??"
    putStrLn answer