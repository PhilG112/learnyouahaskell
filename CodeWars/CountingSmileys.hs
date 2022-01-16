module CodeWars.CountingSmileys where

countSmileys :: [String] -> Int
countSmileys = length . filter correct

correct :: String -> Bool
correct [e,m] = e `elem` eyes && m `elem` mouth
correct [e,n,m] = n `elem` nose && correct [e,m]
correct _ = False

eyes :: String
eyes = ":;"
nose :: String
nose = "-~"
mouth :: String
mouth = ")D"