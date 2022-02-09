module CodeWars.HighestAndLowest where

-- This is honestly disgusting
highAndLow :: String -> String
highAndLow [] = ""
highAndLow arr = show (maximum (map read $ words arr :: [Int])) ++ " " ++  show (minimum (map read $ words arr :: [Int]))

-- Cleaner version
-- highAndLow :: String -> String
-- highAndLow xs = show (maximum ns) ++ " " ++ show (minimum ns)
--   where ns = (map read $ words xs) :: [Int]