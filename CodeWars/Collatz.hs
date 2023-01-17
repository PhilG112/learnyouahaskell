module CodeWars.Collatz where
import Data.List (intercalate)

collatz :: Int -> String
collatz n = collatz' n (show n)
    where
        collatz' 1 s = s
        collatz' n [] = ""
        collatz' n s
            | even n = collatz' divvy (s ++ "->" ++ show divvy)
            | odd n = collatz' trip (s ++ "->" ++ show trip)
            where
                divvy = n `div` 2
                trip = n * 3 + 1
            
-- Top solution

collatz2 :: Int -> String
collatz2 = intercalate "->" . map show . walk
  where walk 1 = [1]
        walk n | even n    = n : walk (n `div` 2)
               | otherwise = n : walk (3*n+1)