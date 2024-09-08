module Health (updateHealth) where

updateHealth :: Double -> Double -> Double
updateHealth health damage = max newHealth 0
    where
        newHealth = health - damage