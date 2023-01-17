module CodeWars.MakeTheDeadFishSwim where

parse :: String -> [Int]
parse [] = []
parse s = parse' 0 s where
  parse' _ "" = []
  parse' n ('i':string) = parse' (n+1) string
  parse' n ('d':string) = parse' (n-1) string
  parse' n ('s':string) = parse' (n*n) string
  parse' n ('o':string) = n : parse' n string
  parse' n ( _ :string) = parse' n string