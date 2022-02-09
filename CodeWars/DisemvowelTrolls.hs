module CodeWars.DisemvowelTrolls where

disemvowel :: String -> String
disemvowel arr = filter (`notElem` "aAeEiIoOuU") arr