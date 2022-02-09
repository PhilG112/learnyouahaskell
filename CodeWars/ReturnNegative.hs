module CodeWars.ReturnNegative where

makeNegative :: (Num a, Ord a) => a -> a
makeNegative n
    | signum n == (-1) || signum n == 0 = n
    | otherwise = negate n


-- makeNegative :: Num a => a -> a
-- makeNegative = negate . abs