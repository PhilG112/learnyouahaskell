module Hackerrank.PlusMinus where

import Text.Printf

-- https://www.hackerrank.com/challenges/plus-minus/problem?isFullScreen=true

lengthRatio :: [Int] -> [Int] -> Double
lengthRatio a b = fromIntegral (length a) / fromIntegral (length b)

plusMinusZero :: [Int] -> String
plusMinusZero a = unlines $ map (show . lengthRatio a) [ps, ns, zs]
    where
        ps = filter (> 0) a
        ns = filter (< 0) a
        zs = filter (== 0) a  

-- plusMinus :: [Int] -> ()
-- plusMinus arr = do
--     let p = length $ filter (>0) arr
--     let n = length $ filter (<0) arr
--     let z = length $ filter (==0) arr
--     let vs = [p,n,z]
--     let u = length arr
--     mapM_ printf' [((fromIntegral z) / (fromIntegral u))]


-- plusMinus' :: [Int] -> String
-- plusMinus' [] = ""
-- plusMinus' arr = mapM_ (printf "%.6f") arr

-- printf' :: (Fractional a) => a -> String
-- printf' n = printf "%.6f" n