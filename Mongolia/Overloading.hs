{-# LANGUAGE InstanceSigs #-}
module Mongolia.Overloading where


example :: (Eq a, Num p) => (a, p) -> (a, b) -> p
example (x1, x2) (y1, y2) =
    if x1 == y1
        then x2
        else 0

class MyEq a where
    (===) :: a -> a -> Bool 

(=/=) :: MyEq a => a -> a -> Bool 
x =/= y = not (x === y)

instance MyEq Bool where
    (===) :: Bool -> Bool -> Bool 
    (===) True True = True 
    (===) False False = True 
    (===) _ _ = False

instance MyEq a => MyEq [a] where
    (===) :: MyEq a => [a] -> [a] -> Bool
    (===) [] [] = True 
    (===) [] (y:ys) = False 
    (===) (x:xs) [] = False 
    (===) (x:xs) (y:ys) = x === y && xs === ys

-- Continue on at 45:58