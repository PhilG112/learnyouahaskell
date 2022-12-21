module CodeWars.BreakCamelCase where
import Data.Char (isUpper)
import Data.List.Split

-- My Solution doesnt work causes infinite loop
solution :: String -> String
solution s = buildSplitString s

buildSplitString :: String -> String
buildSplitString [] = []
buildSplitString str =  fst broken ++ buildSplitString (snd broken)
    where
        broken = break isUpper str

-- Best solution

solution2 :: String -> String
solution2 = unwords . split (startsWithOneOf ['A'..'Z'])

-- Without other packages

solution3 :: String -> String
solution3 (x:[]) = [x]
solution3 (x:xs) = x : c ++ solution xs 
    where c = if isUpper (head xs) then " " else ""