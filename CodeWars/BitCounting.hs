{-# LANGUAGE CPP #-}
module CodeWars.BitCounting where

import Numeric (showIntAtBase)
import Data.Char (intToDigit)

import Data.Bits {- /* -} hiding {- */ -} (popCount, popCountDefault)

countBits'' :: Int -> Int
countBits'' = popCount

countBits :: Int ->
     Int
countBits i = countOnes $ showIntAtBase 2 intToDigit i ""

countOnes :: String -> Int
countOnes = length . filter (== '1')

-- Best solution
-- This approach exploits the fact that when you perform integer division by 2,
-- you're effectively shifting the binary representation of the number one place
-- to the right. And the remainder when divided by 2 (n mod 2) gives you the least
-- significant bit, which you add to the count. This process continues 
-- recursively until the number becomes 0.
countBits' :: Int -> Int
countBits' 0 = 0
countBits' n = n `mod` 2 + countBits (n `div` 2)