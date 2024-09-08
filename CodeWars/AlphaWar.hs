module AlphaWar where

import qualified Data.Map as M 

alphabetWar :: String -> String
alphabetWar str
    | l > r = "Left side wins!"
    | l < r = "Right side wins!"
    | otherwise = "Let's fight again!"
    where
        l = calc str leftSide
        r = calc str rightSide

calc :: String -> M.Map Char Int -> Int
calc [] _ = 0
calc (x:xs) map = case M.lookup x map of
    Just v -> calc xs map + v
    Nothing -> calc xs map

leftSide :: M.Map Char Int
leftSide = M.fromList [('w', 4),('p', 3),('b', 2),('s', 1)]

rightSide :: M.Map Char Int
rightSide = M.fromList [('m', 4),('q', 3),('d', 2),('z', 1)]

-- Best solution
alphabetWar2 :: String -> String
alphabetWar2 s
  | result s > 0 = "Right side wins!"
  | result s < 0 = "Left side wins!"
  | otherwise = "Let's fight again!"
  where
    power 'm' = 4
    power 'q' = 3
    power 'd' = 2
    power 'z' = 1
    power 's' = -1
    power 'b' = -2
    power 'p' = -3
    power 'w' = -4
    power _ = 0
    result = sum . map power