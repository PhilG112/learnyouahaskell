module GravityFlip where
import Data.List

gravityFlip :: Char -> [Int] -> [Int]
gravityFlip direction arr
    | direction == 'L' = reverse $ sort arr
    | otherwise = sort arr

-- Top answer
gravityFlip2 :: Char -> [Int] -> [Int]
gravityFlip2 'R' = sort
gravityFlip2 'L' = reverse . sort