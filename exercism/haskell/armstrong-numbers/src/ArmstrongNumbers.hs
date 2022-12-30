module ArmstrongNumbers (armstrong) where
import Data.Char

armstrong :: Int -> Bool
armstrong n = d n == n
    where
        d :: Int -> Int
        d original =
            let
                s = show original
                l = length s
                mapped = map (\c -> digitToInt c ^ l) s
            in
                sum mapped