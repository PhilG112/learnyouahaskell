module Main where

main :: IO ()
main = print "hi"

-- Unit 1 Lesson 4
compareLastNames :: Ord a1 => (a2, a1) -> (a3, a1) -> Ordering
compareLastNames name1 name2
  | lastName1 > lastName2 = GT
  | lastName1 < lastName2 = LT
  | otherwise = EQ
  where
      lastName1 = snd name1
      lastName2 = snd name2

-- Q4.1
compareLastNamesWithCompare :: Ord l1 => (String, l1) -> (String, l1) -> Ordering
compareLastNamesWithCompare name1 name2 = compare (snd name1) (snd name2)

-- Q4.2
dcOffice :: (a, [Char]) -> [Char]
dcOffice name = nameText ++ " - PO Box 456 - Reno, NV 89523"
    where nameText = snd name  ++ " Esq."