module Main where
import qualified Data.Map as Map

main :: IO ()
main = print $ findKey "betty" phoneBook

phoneBook :: [([Char], [Char])]
phoneBook =
    [("betty","555-2938")
    ,("bonnie","452-2928")
    ,("patsy","493-2928")
    ,("lucille","205-2928")
    ,("wendy","939-8282")
    ,("penny","853-2492")
    ]

type MyList k v = [(k,v)]

findKey :: (Eq k) => k -> MyList k v -> Maybe v
findKey key [] = Nothing
findKey key ((k,v):xs) = if key == k
                            then Just v
                            else findKey key xs



data LockerState = Taken | Free deriving (Show, Eq)
type Code = String
type LockerMap = Map.Map Int (LockerState, Code)

lockers :: LockerMap
lockers = Map.fromList
    [(100,(Taken,"ZD39I"))
    ,(101,(Free,"JAH3I"))
    ,(103,(Free,"IQSA9"))
    ,(105,(Free,"QOTSA"))
    ,(109,(Taken,"893JJ"))
    ,(110,(Taken,"99292"))
    ]

lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber map =
    case Map.lookup lockerNumber map of
        Nothing -> Left $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"
        Just (state, code) -> if state /= Taken
                                then Right code
                                else Left $ "Locker " ++ show lockerNumber ++ " is already taken!"


-- Add two numbers
addTwo:: Int -> Int -> Int
addTwo a b = a + b

-- Sum list
sumList :: [Int] -> Int
sumList [] = 0
sumList x = sum x

sumEvenList :: [Int] -> Int
sumEvenList [] = 0
sumEvenList a = sum [x | x <- a, even x]
