module CodeWars.SumOfTheFirstNthTermOfSeries where
import Text.Printf

series :: [Double]
series = map (1/) [1, 4 ..]

seriesSum :: Integer -> String
seriesSum n = printf "%.2f" $ sum $ take (fromInteger n) series