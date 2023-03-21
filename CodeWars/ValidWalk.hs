module CodeWars.ValidWalk where

type X = Int
type Y = Int
type Mins = Int

isValidWalk :: [Char] -> Bool
isValidWalk walk = calcWalk walk 0 0 10

calcWalk :: String -> X -> Y -> Mins -> Bool
calcWalk [] 0 0 0             = True
calcWalk _ _ _ 0              = False
calcWalk ('n':walk) x y mins  = calcWalk walk x (y + 1) (mins - 1)
calcWalk ('s':walk) x y mins  = calcWalk walk x (y - 1) (mins - 1)
calcWalk ('e':walk) x y mins  = calcWalk walk (x + 1) y (mins - 1)
calcWalk ('w':walk) x y mins  = calcWalk walk (x - 1) y (mins - 1)
calcWalk _ _ _ _              = False

-- Highest rated solution?
isValidWalk2 :: [Char] -> Bool
isValidWalk2 walk = length (take 11 walk) == 10
    && count 'w' walk == count 'e' walk
    && count 'n' walk == count 's' walk

count :: Eq a => a -> [a] -> Int
count c xs = length $ filter (== c) xs