module CodeWars.GrowthOfPopulation where

-- THis kata is bugged

nbYear :: Int -> Double -> Int -> Int -> Int
nbYear pop percent aug finish = go pop percent aug finish 0
  where
    go :: Int -> Double -> Int -> Int -> Int -> Int
    go p' p a f i
      | p' >= f = i
      | otherwise = go calc p a f (i+1)
        where
          calc = p' + round ((fromIntegral p' * (p / 100)) + fromIntegral a)

-- Top Solution
nbYear2 :: Int -> Double -> Int -> Int -> Int
nbYear2 p0 percent aug p
  = length
  $ takeWhile (< p)
  $ iterate ((+ aug ) . floor . (* (1+percent/100)) . fromIntegral) p0