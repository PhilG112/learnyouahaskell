module Main where

main :: IO ()
main = print "hello"

data Base = A | T | G | C deriving (Eq, Show)
type DNA = [Base]

dnaStrand :: DNA -> DNA
dnaStrand [] = []
dnaStrand (x:xs)
    | x == A = T : dnaStrand xs
    | x == T = A : dnaStrand xs
    | x == G = C : dnaStrand xs
    | x == C = G : dnaStrand xs
    | otherwise = dnaStrand xs

-- dnaStrand :: DNA -> DNA
-- dnaStrand = map $ \b -> case b of
--   A -> T
--   T -> A
--   C -> G
--   G -> C