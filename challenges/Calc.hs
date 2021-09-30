{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Calc (calculate) where

type Operator = Double -> Double -> Double
type Entry = (String, Operator)
type Register = [Entry]

modulu :: Double -> Double -> Double
modulu a b = fromIntegral $ mod (round a) (round b)

operatorRegister :: Register
operatorRegister = [
        ("+", (+)),
        ("*", (*)),
        ("/", (/)),
        ("*", (*)),
        ("%", modulu)
    ]

calculate :: String -> Maybe Double
calculate = eval operatorRegister . words

eval :: Register -> [String] -> Maybe Double
-- Called when only 1 element is unparsed
-- _ means we discard the value, we ignore it.
-- [unparsed] is matched if the parameter is a list with a single element in which case the number = the element
eval _ [unparsed] = read unparsed
-- ((operator, function):xs) unparsed = means take the first element of the lsit and bind the elements in the tiple operator and function then bind the rest of the list to xs
eval ((stringOperator, functionOperator):opRegisterTail) unparsed =
    -- in this example span will keep on taking elements until the current element is 5 then then it stops and returns a tuple with the content before the element on the left side and the rest on the right side. E.g print $ span (/=5) [1..10] outputs ([1,2,3,4], [5,6,7,8,9,10]) 
    -- 5 * 2 + 6
    case span (/= stringOperator) unparsed of
        (_, [])             -> eval opRegisterTail unparsed
        (beforeOp, afterOp) -> functionOperator
                                -- <$> and <*> life the functions to understand "Maybe". Maybe is like int? in c#, nullables.
                                <$> eval operatorRegister beforeOp
                                <*> eval operatorRegister (drop 1 afterOp)

