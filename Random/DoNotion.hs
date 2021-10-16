module Random.DoNotion where

-- Bind 3 (>>=) to the lamba (\x -> ..) to show it with !
-- Just 3 >>= (\x -> Just (show x ++ "!"))

foo :: Maybe String  
foo = Just 3   >>= (\x -> 
        Just "!" >>= (\y -> 
            Just (show x ++ y)))

-- Above in do notion
foo2 :: Maybe String
foo2 = do
    x <- Just 3
    y <- Just "!"
    Just (show x ++ y)