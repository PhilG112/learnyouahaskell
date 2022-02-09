module CodeWars.SquareSum where

squareSum :: [Integer] -> Integer
squareSum [] = 0
squareSum arr = sum $ map (^ 2) arr

-- squareSum :: [Integer] -> Integer
-- squareSum = foldr (\x s -> x*x + s) 0