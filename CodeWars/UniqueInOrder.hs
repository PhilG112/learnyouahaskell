module CodeWars.UniqueInOrder where
import Data.List

-- AAAABBBCCDAABBB

uniqueInOrder :: Eq a => [a] -> [a]
uniqueInOrder arr =  map head $ group arr

-- Without built in functions
-- uniqueInOrder :: Eq a => [a] -> [a]
-- uniqueInOrder [] = []
-- uniqueInOrder (s:[]) = [s]
-- uniqueInOrder (a:b:xs) = 
--   if a == b then 
--     uniqueInOrder (a:xs) 
--   else 
--     a : uniqueInOrder (b:xs)