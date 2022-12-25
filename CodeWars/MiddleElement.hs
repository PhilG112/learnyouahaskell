module CodeWars.MiddleElement where
import Data.List

-- My busted shit
gimme :: (Ord a, Num a) => (a, a, a) -> Int
gimme (a, b, c) = getValue (a,b,c)

getValue :: (Ord a, Num a) => (a,a,a) -> Int
getValue (a,b,c) =
    let sortedList = sort (tupToList (a,b,c))
        middleValue = sortedList !! 1
    in 
        matchResult (a,b,c) middleValue

matchResult :: (Ord a, Num a) => (a,a,a) -> a -> Int
matchResult (_,_,_) _ = -1
matchResult (a,b,c) n
    | a == n = a
    | b == n = b
    | c == n = c
    | otherwise = -1

tupToList :: (Num a) => (a,a,a) -> [a]
tupToList (a,b,c) = [a,b,c]

-- Nice solution
gimme2 :: Ord a => (a, a, a) -> Int
gimme2 (a, b, c) 
  | between a (b,c) = 0
  | between b (a,c) = 1
  | between c (a,b) = 2
  | otherwise       = error "Input not within kata specification"
  where between x (y,z) = (y < x && x < z) || (z < x && x < y)