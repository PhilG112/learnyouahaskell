module CodeWars.RockPaperScissors where

winConditions :: [(String, String)]
winConditions = [
                ("paper", "rock"),
                ("scissors", "paper"),
                ("rock", "scissors")
                ]

rps :: String -> String -> String
rps p1 p2
    | t `elem` winConditions = "Player 1 won!"
    | p1 == p2 = "Draw!"
    | otherwise = "Player 2 won!"
    where t = (p1,p2)

-- Top Solution
rps2 :: String -> String -> String
rps2 p1 p2 | p1 == p2 = "Draw!"
          | (p1, p2) `elem` [("rock", "scissors"), ("paper", "rock"), ("scissors", "paper")] = "Player 1 won!"
          | otherwise = "Player 2 won!"