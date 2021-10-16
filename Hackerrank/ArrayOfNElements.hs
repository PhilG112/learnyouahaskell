module Hackerrank.ArrayOfNElements where

fn :: Int -> [Int]
fn n = [0..n-1]

main :: IO ()
main = do
    n <- readLn :: IO Int
    print (fn(n))