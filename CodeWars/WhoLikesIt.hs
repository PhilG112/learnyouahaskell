module CodeWars.WhoLikesIt where
import Text.Printf

-- https://www.codewars.com/kata/5266876b8f4bf2da9b000362/train/haskell

likes :: [String] -> String
likes [] = "no one likes this"
likes arr
    | length arr >= 4 = _
    | length arr == 1 = printf "%d likes this" $ head arr
    | length arr == 2 = printf "%d and %d like this" x y
    | length arr == 3 = _
    | otherwise = _