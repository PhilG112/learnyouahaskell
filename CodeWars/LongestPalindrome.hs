module LongestPalindrome where

import Data.List ( inits, tails )

-- For input "abc", start from the bottom function going up (aka right to left)
longestPalindrome :: Eq a => [a] -> Int
longestPalindrome =
    maximum . -- 1 -- return the mximum length
    map length . -- [0,1,0,1,0,1,0] -- Map the length of each palindrome to get a list of their lengths
    filter (\s -> s == reverse s) . -- ["","a","","b","","c",""] -- Get only segments that are palindromes
    concatMap tails . -- ["","a","","ab","b","","abc","bc","c",""] -- returns all final segments of the argument,
                      -- longest first. You basically end up with a list of both inits and tails computed on "abc"
    inits -- ["","a","ab","abc"] -- returns all initial segments of the argument, shortest first