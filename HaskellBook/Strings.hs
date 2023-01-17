module HaskellBook.Strings where


pp :: IO ()
pp = putStrLn "hi" >>
    putStrLn "Pissoff dog" >>
    putStrLn "I love dogs"

data Mood = Blah | Woot deriving (Show, Eq)

changeMood :: Mood -> Mood
changeMood Blah = Woot
changeMood Woot = Blah


instance Ord Mood where
    compare Blah Woot = LT
    compare Woot Blah = GT
    compare Woot Woot = EQ
    compare Blah _ = LT


palindrome :: (Eq a) => [a] -> Bool
palindrome [] = False
palindrome arr = reversed arr == arr
    where
        reversed :: [a] -> [a]
        reversed [] = []
        reversed (x:xs) = reversed xs ++ [x]

myAbs :: Integer -> Integer
myAbs 0 = 0
myAbs i = if i < 0 then i * (-1) else i

f :: (a, b) -> (c, d) -> ((b, d), (a, c))
f (a, b) (c, d) = ((b,d), (a,c))

x = (+)

funcy xs = x w 1
    where w = length xs

