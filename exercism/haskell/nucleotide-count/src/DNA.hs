module DNA (nucleotideCounts, Nucleotide(..)) where

import qualified Data.Map as Map
import Data.Char

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show, Read)

nucleotideCounts :: String -> Either String (Map.Map Nucleotide Int)
nucleotideCounts xs
    | validateInput xs = Right (countNucs xs singletonMap)
    | otherwise = Left "ERROR"

countNucs :: String -> Map.Map Nucleotide Int -> Map.Map Nucleotide Int
countNucs [] m = m
countNucs (x:xs) m
    | x == head (show A) = countNucs xs (Map.adjust (+1) A m)
    | x == head (show C) = countNucs xs (Map.adjust (+1) C m)
    | x == head (show G) = countNucs xs (Map.adjust (+1) G m)
    | x == head (show T) = countNucs xs (Map.adjust (+1) T m)
    | otherwise = countNucs xs m

validateInput :: String -> Bool
validateInput [] = True
validateInput (x:xs)
    | x `elem` nucsToString = validateInput xs
    | otherwise = False

nucsToString :: String
nucsToString = concatMap show [A, C, G, T]

singletonMap :: Map.Map Nucleotide Int
singletonMap = Map.fromList
    [ (A, 0)
    , (C, 0)
    , (G, 0)
    , (T, 0)
    ]

-- Other solution

nucleotideCounts2 :: String -> Either String (Map.Map Nucleotide Int)
nucleotideCounts2 xs
  | isValid xs = Right $ count xs
  | otherwise = Left xs
  where
    isValid = all (`elem` "ACGT")

count :: String -> Map.Map Nucleotide Int
count xs = Map.fromListWith (+) [(read [toUpper c], 1) | c <- xs]