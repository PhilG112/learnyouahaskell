module CodeWars.PrinterErrors where

-- https://www.codewars.com/kata/56541980fa08ab47a0000040/train/haskell

printerError :: [Char] -> [Char]
printerError s = show errorLength ++ "/" ++ show (length s)
    where
        ogLength = length s
        errorLength = length $ filter (`notElem` ['a'..'m']) s

-- Top solution
printerError2 :: [Char] -> [Char]
printerError2 s = show errNum ++ "/" ++ show totNum
  where
    errNum = length $ filter (`elem` ['n'..'z']) s
    totNum  = length s    