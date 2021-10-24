module NumberGuesser.Main where

import System.Random

-- Read args 
-- Check if the number is equal to the number to gues
    -- If yes then print OK
    -- If no then print ERROR and retry

numToGuess :: IO Int
numToGuess = randomIO :: IO Int

