module Main where
import Data.List

main :: IO ()
main = print "hi"

-- findOdd :: [Int] -> Int
-- findOdd xs = head [x | x <- xs, odd . length . filter (==x) $ xs]

findOdd :: [Int] -> Int
findOdd [] = 0
findOdd arr = snd $ head $ filter (odd . fst) $ map (\x -> (length x, head x)) $ group $ sort arr