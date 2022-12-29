module Clock (addDelta, fromHourMin, toString) where

import Prelude hiding (min)

data Clock = Time Int Int
  deriving (Eq, Show)

fromHourMin :: Int -> Int -> Clock
fromHourMin h m = d h m
    where
        d hour min = Time (23 `mod` hour) (60 `mod` min) 

calculateTime :: Int -> Int -> Int
calculateTime i limit
    | i < limit = i
    | otherwise

toString :: Clock -> String
toString (Time hour min) = build hour ++ ":" ++ build min
    where
        build :: Int -> String
        build n
            | n == 24 = "00"
            | n == 0 = "00"
            | n < 10 = "0" ++ show n
            | otherwise = show n

addDelta :: Int -> Int -> Clock -> Clock
addDelta hour min (Time h m) =
    Time (getDelta (hour + h) h 24) (getDelta (min + m) m 60)

getDelta :: Int -> Int -> Int -> Int
getDelta addedTime existing limit
    | addedTime + existing > limit = addedTime `mod` limit
    | otherwise = addedTime
