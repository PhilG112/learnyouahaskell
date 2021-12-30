module Hackerrank.ArrayRotation where

import qualified Data.Sequence as S
import Data.Foldable
import Prelude hiding (drop, take)
import Data.Sequence ((><))


rotLeft :: S.Seq Int -> Int -> S.Seq Int
rotLeft S.Empty _ = S.Empty
rotLeft arr 0 = arr
rotLeft arr n = rotLeft (b arr) (n-1)
    where
        b :: S.Seq Int -> S.Seq Int
        b s = S.drop 1 (s >< S.take 1 s)