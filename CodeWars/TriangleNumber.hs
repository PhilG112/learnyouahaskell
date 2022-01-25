module CodeWars.TriangleNumber where

isTriangleNumber :: Integer -> Bool
isTriangleNumber n = check . truncate . sqrt . fromIntegral $ 2 * n
  where
        check a
            | a * a + a == 2 * n = True
            | otherwise = False