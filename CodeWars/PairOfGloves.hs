module PairOfGloves where
import Data.List ( group, sort )

data Colour = Red | Blue | Green deriving (Show,Eq,Ord,Enum,Bounded)

numberOfPairs :: [Colour] -> Int
numberOfPairs xs = foldr (\a b -> a `div` 2 + b) 0 numOfPairs
    where
        numOfPairs = map length $ group $ sort xs
        
-- Best solution
numberOfPairs2 :: [Colour] -> Int
numberOfPairs2 = sum . map ((`div` 2) . length) . group . sort