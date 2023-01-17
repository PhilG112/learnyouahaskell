module CodeWars.CategorizeNewMember where

data Membership = Open | Senior deriving (Eq, Show)
openOrSenior :: [(Int, Int)] -> [Membership]
openOrSenior [] = []
openOrSenior (x:xs)
    | fst x >= 55 && snd x > 7 = Open : openOrSenior xs
    | otherwise = Senior : openOrSenior xs

-- Top solution
openOrSenior2 :: [(Int, Int)] -> [Membership]
openOrSenior2 = map (\(a,b) -> if a >= 55 && b > 7 then Senior else Open)