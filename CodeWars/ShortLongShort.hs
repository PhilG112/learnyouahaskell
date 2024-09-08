module ShortLongShort where
import Data.Foldable (maximumBy, minimumBy)
import Data.Function

shortLongShort :: String -> String -> String
shortLongShort a [] = a
shortLongShort [] b = b
shortLongShort a b = short ++ long ++ short
    where
        long = maximumBy (compare `on` length) [a, b]
        short = minimumBy (compare `on` length) [a, b]

-- Best solution
shortLongShort2 :: String -> String -> String
shortLongShort2 a b
    | length a > length b = b ++ a ++ b
    | otherwise           = a ++ b ++ a