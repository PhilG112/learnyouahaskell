{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiWayIf #-}
module Main where

import System.Environment ( getArgs )
import Data.List (intercalate)
import Data.Text hiding (length, unwords, words, map)

argumentList :: [String]
argumentList = [
      "-d" -- Specify a directory
    , "-path" -- Specify the path to a directory
    , "-files" -- ; separated files to compress
    ]

data Args = Directory | Path | Files
    deriving (Eq)

instance Show Args where
    show Directory = "-d"
    show Path = "-path"
    show Files = "-files"

main :: IO ()
main = do
    args <- getArgs
    let strippedArgs = map (unwords . words) args
    parseArgs strippedArgs

parseArgs :: [String] -> IO ()
parseArgs [] = putStrLn "Please provide an argument."
parseArgs arr
    | allValidArgs arr = putStrLn "Invalid args"
    | length mappedArgs == 1 = putStrLn "ok"
    | not (Directory `elem` mappedArgs && Path `elem` mappedArgs) = putStrLn "-path and -d must be provided together"
    | otherwise = doWork mappedArgs
    where
        mappedArgs = map (\x -> if
            | x == "-d" -> Directory
            | x == "-path" -> Path
            | x == "-files" -> Files
            | otherwise -> Directory) arr

doWork :: [Args] -> IO ()
doWork = error "not implemented"

-- Refactor this
allValidArgs :: [String] -> Bool
allValidArgs [] = False
allValidArgs [x] = isInArgsList x
allValidArgs (x:xs) = isInArgsList x && allValidArgs xs
        
isInArgsList :: String -> Bool
isInArgsList a = a `elem` argumentList