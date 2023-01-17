module CodeWars.CountByx where

-- x = 2, n = 5 -> [2,4,6,8,10]
countBy :: Integer -> Int -> [Integer]
countBy _ 0 = [] 
countBy x n = countBy x (n-1) ++ [x * toInteger n]

-- Top solution
countBy2 :: Integer -> Int -> [Integer]
countBy2 x n = take n [x, x + x..]