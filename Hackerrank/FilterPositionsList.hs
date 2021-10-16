module Hackerrank.FilterPositionsList where

f :: [Int] -> [Int]
f [] = []
-- Zip the current element into a tuple with its index
-- and filter where the index is even
f (x:xs) = [x | (i, x) <- zip [0..] xs, even i]


-- This part deals with the Input and Output and can be used as it is. Do not modify it.
main :: IO ()
main = do
    inputdata <- getContents
    mapM_ (putStrLn. show). f. map read. lines $ inputdata