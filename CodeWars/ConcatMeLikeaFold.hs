module CodeWars.ConcatMeLikeaFold where
 
 -- hmmm ?
 
p :: a -> (t -> [a]) -> t -> [a]
p x f xs = x : f xs

q :: a -> a
q = id

r :: [a]
r = []


foldConcat :: [[a]] -> [a]
foldConcat = foldr (foldr p q) r