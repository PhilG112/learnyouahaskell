module Hackerrank.PalindromeIndex where

palindromeIndex :: String -> Int 
palindromeIndex [] = -1
palindromeIndex s =


isPalindrome :: String -> Bool
isPalindrome [] = False
isPalindrome s = s == reverse s