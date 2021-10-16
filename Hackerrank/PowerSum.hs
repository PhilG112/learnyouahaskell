{-# LANGUAGE DuplicateRecordFields, FlexibleInstances, UndecidableInstances #-}

module Main where

import Control.Monad
import Data.Array
import Data.Bits
import Data.List
import Data.List.Split
import Data.Set
import Data.Text
import Debug.Trace
import System.Environment
import System.IO
import System.IO.Unsafe

--
-- Complete the 'powerSum' function below.
--
-- The function is expected to return an INTEGER.
-- The function accepts following parameters:
--  1. INTEGER X
--  2. INTEGER N
--

powerSum X N = do
    -- Write your code here

lstrip = Data.Text.unpack . Data.Text.stripStart . Data.Text.pack
rstrip = Data.Text.unpack . Data.Text.stripEnd . Data.Text.pack

main :: IO()
main = do
    stdout <- getEnv "OUTPUT_PATH"
    fptr <- openFile stdout WriteMode

    XTemp <- getLine
    let X = read $ lstrip $ rstrip XTemp :: Int

    NTemp <- getLine
    let N = read $ lstrip $ rstrip NTemp :: Int

    let result = powerSum X N

    hPutStrLn fptr $ show result

    hFlush fptr
    hClose fptr