module CodeWars.AreTheyTheSame where
import Data.List

-- [121, 144, 19, 161, 19, 144, 19, 11]
-- [11*11, 121*121, 144*144, 19*19, 161*161, 19*19, 144*144, 19*19]

comp :: [Int] -> [Int] -> Bool
comp as bs
    | length as /= length bs = False
    | mapLists (map (ceiling . getSquareRoot) bs) as = True
    | otherwise = False

getSquareRoot :: Int -> Double
getSquareRoot n = sqrt $ fromIntegral n

mapLists :: [Int] -> [Int] -> Bool
mapLists [] [] = True
mapLists a1 a2 = c (sort a1) (sort a2)
    where
    c :: [Int] -> [Int] -> Bool
    c [] [] = True
    c (x:xs) (y:ys)
        | x == y = c xs ys
        | otherwise = False

-- LOL, im stupidd
-- comp :: [Integer] -> [Integer] -> Bool
-- comp as bs = sort (map (^2) as) == sort bs