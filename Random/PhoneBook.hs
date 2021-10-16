{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Random.PhoneBook where

type Name = String
type Number = String
type PhoneBook = [(Name, Number)]

add :: PhoneBook -> Name -> Number -> PhoneBook
add [] _ _ = []
add pb n num = pb ++ [(n, num)]

-- Can we improve?
exists :: PhoneBook -> (Name, Number) -> Bool
exists [] _ = False
exists (x:xs) nn
    | fst x /= fst nn = exists xs nn
    | fst x == fst nn && snd x == snd nn = True
    | otherwise = False

removeByName :: PhoneBook -> Name -> PhoneBook
removeByName [] _ = []
removeByName (x:xs) name
    | fst x == name = xs
    | otherwise = removeByName xs name

removeByNumber :: PhoneBook -> Number -> PhoneBook
removeByNumber [] _ = []
removeByNumber (x:xs) number
    | snd x == number = xs
    | otherwise = removeByName xs number