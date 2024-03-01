module CodeWars.CreditCardMask where

maskify :: String -> String
maskify [] = []
maskify str =
    let split = splitAt (length str - 4) str
    in convertToAsteriks (fst split) ++ snd split


convertToAsteriks :: String -> String
convertToAsteriks = map (const '*')

-- better solutions
maskify2 :: String -> String
maskify2 str = replicate l '#' ++ drop l str
    where l = length str - 4

maskify3 :: String -> String
maskify3 s
  | length s < 5 = s
  | otherwise = "#" ++ maskify (tail s)