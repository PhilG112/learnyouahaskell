{-# LANGUAGE RecordWildCards #-}
module CodeWars.RgbToHex where

import qualified Data.Map as Map
import Numeric (showHex)

hexMap :: Map.Map Int String
hexMap = Map.fromList
    [ (0,"0")
    , (1, "1")
    , (2, "2")
    , (3, "3")
    , (4, "4")
    , (5, "5")
    , (6, "6")
    , (7, "7")
    , (8, "8")
    , (9, "9")
    , (10, "A")
    , (11, "B")
    , (12, "C")
    , (13, "D")
    , (14, "E")
    , (15, "F")
    ]


-- https://www.codewars.com/kata/513e08acc600c94f01000001/train/csharp

data RGB = RGB {
    red :: Int
  , green :: Int
  , blue :: Int
} deriving Show

rgb2Hex :: RGB -> String
rgb2Hex RGB{..} = _

intToHex :: Int -> String
intToHex 0 = "0"
intToHex n = case f of
    Nothing -> ""
    Just v -> v
    where
        d = properFraction $ toRational $ fromIntegral n / 16
        f = do
            h1 <- Map.lookup (fst d) hexMap
            h2 <- Map.lookup (toInteger $ snd d * 16) hexMap
            return $ h1 ++ h2

    -- where
    --     d = fromIntegral n / fromIntegral 16
    --     j = showHex d "" ++ showHex (snd $ properFraction d) ""
