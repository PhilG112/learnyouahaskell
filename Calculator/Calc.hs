{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Calculator.Calc where

import Control.Applicative ((<$>), (<*>))

type Operator = Double -> Double -> Double
type Register = [(String, Operator)]

modulu :: Double -> Double -> Double
modulu a b = fromIntegral $ mod (round a) (round b)

operatorRegister :: Register
operatorRegister = [
                ("-", (-)),
                ("+", (+)),
                ("/", (/)),
                ("*", (*)),
                ("%", modulu)
            ]

main :: IO ()
main = print $ calculate "3 * 2 + 5 % 2"

calculate :: String -> Maybe Double
calculate s = eval operatorRegister $ words s

eval :: Register -> [String] -> Maybe Double
eval [] _ = Nothing -- No operator found.
eval _ [] = Nothing -- If a operator don't have anything to operate on.
eval _ [number] = Just $ read number
eval ((operator, function):xs) unparsed =
    case span (/=operator) unparsed of
        (_, []) -> eval xs unparsed
        (beforeOperator, afterOperator) ->
            function
                <$> eval operatorRegister beforeOperator
                <*> eval operatorRegister (drop 1 afterOperator)