module CodeWars.ValidParentheses where

validParentheses :: String -> Bool
validParentheses s = parse s 0

parse :: String -> Int -> Bool
parse [] n = n == 0
parse (x:xs) n
  | n < 0 = False
  | otherwise = case x of
                  '(' -> parse xs (n + 1)
                  ')' -> parse xs (n - 1)