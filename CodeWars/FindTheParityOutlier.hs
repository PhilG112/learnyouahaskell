module CodeWars.FindTheParityOutlier where

import Data.List (partition)

findOutlier :: [Int] -> Int
findOutlier xs = if length o == 1 then head o else head e 
    where
        o = f odd xs
        e = f even xs

f :: Integral a => (a -> Bool) -> [a] -> [a]
f = filter

-- best solution
-- Don't forget about partition!

findOutlier2 :: [Int] -> Int
findOutlier2 xs =
    case partition even xs of
        ([x], _) -> x
        (_, [x]) -> x
        otherwise -> error "invalid input"