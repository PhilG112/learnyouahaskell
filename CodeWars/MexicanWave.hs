module MexicanWave where

wave :: String -> [String]
wave [] = []
wave str = _
    where
        wav :: Int -> String -> String
        wav _ [] = []
        wav i str = _
            
replaceElementAtIndex :: Int -> a -> [a] -> [a]
replaceElementAtIndex _ _ [] = []
replaceElementAtIndex n newVal (x:xs)
    | n == 0 = newVal : xs
    | otherwise = x : replaceElementAtIndex (n-1) newVal xs