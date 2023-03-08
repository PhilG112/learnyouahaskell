module MaxLengthDiff where

mxdiflg :: [String] -> [String] -> Maybe Int
mxdiflg [] _ = Nothing
mxdiflg _ [] = Nothing
mxdiflg s1 s2 = Just $ max (maximum l1 - minimum l2) (maximum l2 - minimum l1)
  where
    l1 = map length s1
    l2 = map length s2