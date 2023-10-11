module CodeWars.DataCompressionRunLength where
import Data.List (groupBy, group)
import Data.Char (digitToInt, isDigit)
import Data.Function (on)

encode :: String -> String
encode s = concatMap encode' $ groupBy (==) s
    where
        encode' :: String -> String
        encode' [] = []
        encode' xs = show (length xs) ++ [head xs]

decode :: String -> String
decode [] = []
decode xs = replicate (read $ fst sp) (head $ snd sp) ++ decode (tail $ snd sp)
    where
        sp = span isDigit xs

-- Top solution
encode' :: String -> String
encode' = concatMap (\xs -> show (length xs) ++ [head xs]) . group

decode' :: String -> String
decode' input = go (groupBy ((==) `on` isDigit) input)
  where
    go :: [String] -> String
    go [] = ""
    go (x : y : zs) = replicate (read x) (head y) ++ go zs
