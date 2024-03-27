module CodeWars.BasicB where

-- I seriously over thought this
basicOp :: Char -> Int -> Int -> Int
basicOp c = op
    where
        op = lookup' c opMap

lookup' ::Eq a => a -> [(a,b)] -> b
lookup' key (x:xs)
    | fst x == key = snd x
    | otherwise = lookup' key xs

opMap :: Integral a => [(Char, a -> a -> a)]
opMap = [('+', (+)), ('-', (-)), ('*', (*)),('/', div)]

-- Best solution
basicOp' :: Char -> Int -> Int -> Int
basicOp' '+' = (+)
basicOp' '-' = (-)
basicOp' '*' = (*)
basicOp' '/' = div