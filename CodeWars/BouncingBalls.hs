module CodeWars.BouncingBalls where

import Control.Monad.State

bouncingBall :: Double -> Double -> Double -> Int
bouncingBall h b w = evalState bouncingBall' (h, b, w)

getNextBounce :: State (Double, Double) Double
getNextBounce = do
    (height, bounce) <- get
    let

bouncingBall' :: State (Double, Double, Double) Int
bouncingBall' = _
