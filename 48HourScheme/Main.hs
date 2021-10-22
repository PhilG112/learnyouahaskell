module Main where

import Text.ParserCombinators.Parsec hiding (spaces)
import System.Environment

main :: IO ()
main = do
    (e:_) <- getArgs
    putStrLn (readExpression e)

-- Does the symbol string contain the passed in char?
symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

readExpression :: String -> String 
readExpression input = case parse symbol "lisp" input of
    Left err -> "No Match: " ++ show err
    Right val -> "Found Value"
