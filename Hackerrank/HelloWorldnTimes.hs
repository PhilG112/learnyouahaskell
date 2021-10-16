{-# LANGUAGE FlexibleInstances, UndecidableInstances, DuplicateRecordFields #-}

module Hackerrank.FunctionalP where

import Control.Monad
import Data.Array
import Data.Bits
import Data.List
import Data.List.Split
import Data.Set
import Debug.Trace
import System.Environment
import System.IO
import System.IO.Unsafe


t :: (Eq t, Num t) => t -> IO ()
t 0 = return ()
t n = do 
    putStrLn "Hello World"
    t (n-1)

main :: IO()
main = do
    n <- readLn :: IO Int
    t n
    