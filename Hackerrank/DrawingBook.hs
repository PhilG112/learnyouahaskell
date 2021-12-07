module Hackerrank.DrawingBook where

-- NumOfPages -> Target -> NumOfSteps
pageCount :: Int -> Int -> Int
pageCount 0 _  = 0
pageCount _ 0 = 0
pageCount n t = _ (zippy [1..n])
    where
        g = max 

zippy :: [Int] -> [(Int, Int)]
zippy [] = []
zippy [x] = [(x,0)]
zippy (1:xs) = (0, 1) : zippy xs 
zippy (x:y:xs) = (x,y) : zippy xs


-- [(1,2),(3,4),(5,6),(7,8)]
-- length (zippy [1,2,3,4,5])
-- f (g x)