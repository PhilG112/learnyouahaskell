module CalculatingWithFunctions where

plus x = x (+)
minus x = x (flip (-))
times x = x (*)
dividedBy x = x (flip div)

zero,one,two,three,four,five,six,seven,eight,nine :: Num t1 => (t1 -> t2) -> t2
zero f = f 0
one f = f 1
two f = f 2
three f = f 3
four f = f 4
five f = f 5
six f = f 6
seven f = f 7
eight f = f 8
nine f = f 9
