module DNA (toRNA) where

import qualified Data.Map as Map

toRNA :: String -> Either Char String
toRNA [] = Right ""
toRNA (x:xs) = case getRna x of
    Nothing -> Left x
    Just rnaCode -> fmap (rnaCode :) (toRNA xs)

getRna :: Char -> Maybe Char
getRna c = Map.lookup c rnaMap

rnaMap :: Map.Map Char Char
rnaMap =
    Map.fromList
    [ ('G', 'C')
    , ('C', 'G')
    , ('T', 'A')
    , ('A', 'U')
    ]

