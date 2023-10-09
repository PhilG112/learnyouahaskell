module CodeWars.Likes where

-- https://www.codewars.com/kata/5266876b8f4bf2da9b000362/train/haskell
likes :: [String] -> String
likes [] = "no one likes this"
likes [a] = a ++ " likes this"
likes [a,b] = a ++ " and " ++ b ++ " like this"
likes [a,b,c] = a ++ ", " ++ b ++ " and " ++ c ++ " like this"
likes (a:b:xs) = a ++ ", " ++ b ++ " and " ++ show (length xs) ++ " others like this"