{-# LANGUAGE OverloadedStrings #-}
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

main :: IO ()
main = do
    args <- getArgs
    let strippedArgs = map (unwords . words) args
    parseArgs strippedArgs

parseArgs :: [String] -> IO ()
parseArgs [] = putStrLn "Please provide an argument."
parseArgs all
    | not (allValidArgs all) = putStrLn "Invalid args"
    | otherwise = doWork all

doWork :: [String] -> IO ()
doWork (x:xs) = case x of
    "-d" -> putStrLn "OK"

-- Refactor this
allValidArgs :: [String] -> Bool
allValidArgs [] = False
allValidArgs [x] = isInArgsList x
allValidArgs (x:xs) = isInArgsList x && allValidArgs xs
        
isInArgsList :: String -> Bool
isInArgsList a = a `elem` argumentList