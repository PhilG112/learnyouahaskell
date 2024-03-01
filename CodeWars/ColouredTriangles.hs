{-# LANGUAGE DeriveGeneric #-}

module CodeWars.ColouredTriangles where
{-# LANGUAGE TypeApplications #-}

import Debug.Trace
import Control.DeepSeq
import GHC.Generics (Generic)
import Data.Char (ord)

data RGB = R | G | B deriving (Show, Eq)

-- instance NFData RGB
instance Semigroup RGB where
    (<>) :: RGB -> RGB -> RGB
    R <> R = R
    G <> G = G
    B <> B = B

    R <> G = B
    B <> R = G
    G <> B = R

    G <> R = B
    R <> B = G
    B <> G = R

triangle :: String -> String
triangle [] = []
triangle str = show $ head $ compute (stringToRGBList str)

compute :: [RGB] -> [RGB]
compute [a] = [a]
compute [a,b] = [getCombinedColor a b]
compute (a:b:xs) = getCombinedColor a b : compute (b:xs)

createPairs :: [RGB] -> [(RGB, RGB)]
createPairs xs = zip xs (tail xs)

-- compute2 :: [RGB] -> [RGB]
-- compute2 xs = deepseq result result
--   where
--     result = compute' xs

-- compute' :: [RGB] -> [RGB]
-- compute' [a] = trace ("compute called with: " ++ show [a]) [a]
-- compute' [a,b] = trace ("compute called with: " ++ show [a,b]) [getCombinedColor a b]
-- compute' (a:b:xs) = trace ("compute called with: " ++ show (a:b:xs)) (getCombinedColor a b : compute' (b:xs))

getCombinedColor :: RGB -> RGB -> RGB
getCombinedColor x y = x <> y

charToRGB :: Char -> RGB
charToRGB 'R' = R
charToRGB 'G' = G
charToRGB 'B' = B

stringToRGBList :: String -> [RGB]
stringToRGBList = map charToRGB

-- Better solutions (cannot get my version to work)

data Color = B2 | R2 | G2 deriving (Show, Enum)

instance Semigroup Color where
  (<>) :: Color -> Color -> Color
  x <> y = toEnum $ (-fromEnum x - fromEnum y) `mod` 3
  
toColor :: Char -> Color
toColor = toEnum . (`mod` 3) . ord


triangle2 :: String -> String
triangle2 = show 
         . head 
         . until ((1 ==) . length) (zipWith (<>) <*> tail) 
         . map toColor

