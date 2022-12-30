module Clock (addDelta, fromHourMin, toString) where

import Prelude hiding (min)
import Text.Printf (printf)

data Clock = Time Int Int
  deriving (Eq, Show)

data Clock' = Clock' Int deriving (Show, Eq)

fromHourMin :: Int -> Int -> Clock
fromHourMin h m = d h m
    where
        d hour min = Time (23 `mod` hour) (60 `mod` min) 

fromHourMin' :: Int -> Int -> Clock'
fromHourMin' h m = Clock' $ totalMin `mod` minPerDay
    where
        minPerDay = 24*60
        totalMin = (h * 60) + m

calculateTime :: Int -> Int -> Int
calculateTime i limit
    | i < limit = i
    | otherwise = 0

toString :: Clock -> String
toString (Time hour min) = build hour ++ ":" ++ build min
    where
        build :: Int -> String
        build n 
            | n == 24 = "00"
            | n == 0 = "00"
            | n < 10 = "0" ++ show n
            | otherwise = show n

toString' :: Clock' -> String
toString' (Clock' totalMin) = printf "%02d:%02d" h m
    where
        (h, m) = totalMin `divMod` 60

addDelta :: Int -> Int -> Clock -> Clock
addDelta hour min (Time h m) =
    Time (getDelta (hour + h) h 24) (getDelta (min + m) m 60)

addDelta' :: Int -> Int -> Clock' -> Clock'
addDelta' h m (Clock' totalMin) = fromHourMin' h (m + totalMin)

getDelta :: Int -> Int -> Int -> Int
getDelta addedTime existing limit
    | addedTime + existing > limit = addedTime `mod` limit
    | otherwise = addedTime
