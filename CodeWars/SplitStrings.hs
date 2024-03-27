module CodeWars.SplitStrings where

solution :: String -> [String]
solution = doSplit

doSplit :: String -> [String]
doSplit [] = []
doSplit [a] = [[a, '_']]
doSplit (a:b:xs) = [a,b] : doSplit xs