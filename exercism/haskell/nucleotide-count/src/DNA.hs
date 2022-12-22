module DNA (nucleotideCounts, Nucleotide(..)) where

import qualified Data.Map as Map

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map.Map Nucleotide Int)
nucleotideCounts xs = error "You need to implement this function."
