module TestRotate where

testRotate :: [a] -> Int -> [a]
testRotate [] _ = []
testRotate xs 0 = xs
testRotate (x:xs) n = testRotate xs (n - 1) ++ [x]