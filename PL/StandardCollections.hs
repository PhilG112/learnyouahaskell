{-# LANGUAGE ViewPatterns #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module StandardCollections where

import Data.Set ( Set )
import qualified Data.Map as Map
import qualified Data.Sequence as Seq

-- https://hackage.haskell.org/package/containers-0.6.5.1/docs/Data-Set.html

-- Map (basically a dictionary)
-- https://hackage.haskell.org/package/containers-0.6.5.1/docs/Data-Map.html

-- Seq (Orderer collection)
-- https://hackage.haskell.org/package/containers-0.6.5.1/docs/Data-Sequence.html

-- THis is how you pattern match on a seq
length1 :: Seq.Seq a -> Int
length1 (Seq.viewl -> Seq.EmptyL) = 0
length1 (Seq.viewl -> x Seq.:< xs) = 1 + length1 xs