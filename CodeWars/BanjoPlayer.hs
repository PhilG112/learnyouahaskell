module BanjoPlayer where

areYouPlayingBanjo :: String -> String
areYouPlayingBanjo name
    | head name == 'r' || head name == 'R' = name ++ " plays banjo"
    | otherwise = name ++ " does not play banjo"