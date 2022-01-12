module CodeWars.ZerosToEnd where

moveZeros :: [Int] -> [Int]
moveZeros [] = []
moveZeros arr = filter (/=0) arr ++ filter (==0) arr

-- moveZeros :: [Int] -> [Int]
-- moveZeros xs = uncurry (++) $ partition (/=0) xs