{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import qualified Data.Vector as V
import qualified Data.ByteString.Lazy as BL
import Data.Csv

-- Duration,ContentLength,ContentType,Endpoint,FileKey,Status
-- 109,53956,image/png,Generate,20211207/001d6b53-77b0-41d1-93b2-75644ef9815a.png,Success

main :: IO ()
main = do
    f <- BL.readFile "./csvs/imagejpg.csv"
    case decode NoHeader f of
        Left err -> putStrLn err
        Right xs -> V.forM xs $ \(x :: Int, y :: Int) -> putStrLn (x,y)
