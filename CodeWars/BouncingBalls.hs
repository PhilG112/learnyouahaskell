module CodeWars.BouncingBalls where

bouncingBall :: Double -> Double -> Double -> Integer
bouncingBall h b w
    | h > 0 && (b > 0 && b < 1) && w < h = bouncingBall' h b w 1
    | otherwise = -1

bouncingBall' :: Double -> Double -> Double -> Int -> Integer
bouncingBall' h b w i
    | newHeight > w = bouncingBall' newHeight b w (i+2)
    | otherwise = toInteger i
    where
        newHeight = h * b

-- bouncingBall :: Double -> Double -> Double -> Integer
-- bouncingBall h b w 
--   | h > 0 && 0 < b && b < 1 && w < h = 2 + (bouncingBall (h * b) b w)
--   | otherwise = -1