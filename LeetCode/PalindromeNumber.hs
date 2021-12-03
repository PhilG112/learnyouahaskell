module LeetCode.PalindromeNumber where

isPalindrome :: Int -> Bool 
isPalindrome i = show i == reverse (show i)