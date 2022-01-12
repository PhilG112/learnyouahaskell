module CodeWars.Anagrams where
import Data.List ((\\), union, sort)

anagrams :: String -> [String] -> [String]
anagrams _ [] = []
anagrams a arr = filter (\x -> isAnagram a x) arr

isAnagram :: String -> String -> Bool
isAnagram s1 s2 = sort s1 == sort s2
