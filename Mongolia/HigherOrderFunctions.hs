module Mongolia.HigherOrderFunctions where

import Mongolia.Overview
import Prelude hiding (FilePath)

hasBlockProp :: (Txs -> Bool) -> Chain -> Bool 
hasBlockProp prop GenesisBlock = False
hasBlockProp prop (Block chain txs) = prop txs || hasBlockProp prop chain

-- hasBlockProp (\x -> x > 10) chain2
-- hasBlockProp even chain2
-- hasBlockProp (\x -> 4 == x) chain2
-- hasBlockProp (> 10) chain2
-- hasBlockProp (4 ==) chain2

-- Polymorphism

-- Abstract from the type of transactions
data Chain' txs = GenesisBlock' | Block' (Chain' txs) txs

-- Overloading
hasBlock x GenesisBlock = False 
hasBlock x (Block c t) = x == t || hasBlock x c

-- Side effects

type FilePath = String 

readFile :: FilePath -> IO String 

-- lengthOfFile file = lengt (readFIile file) -- Type error

lengthOfFile :: FilePath -> IO Int
lengthOfFile file = length <$> readFile file