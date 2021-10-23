module Main where

import Text.ParserCombinators.Parsec hiding (spaces)
import System.Environment
import Control.Monad

main :: IO ()
main = do
    (e:_) <- getArgs
    putStrLn (readExpression e)

data LispVal = Atom String -- An atom is a letter or sumbol, followed by any number or letters digits or symbols https://schemers.org/Documents/Standards/R5RS/HTML/r5rs-Z-H-5.html#%_sec_2.1
             | List [LispVal]
             | DottedList [LispVal] LispVal -- Also called improper list (a b . c) stores all values but the last which is stored in a sperapte value
             | Number Integer 
             | String String
             | Bool Bool

parseAtom :: Parser LispVal
parseAtom = do
    first <- letter <|> symbol -- Get the first letter if its a letter or symbol
    rest <- many (letter <|> digit <|> symbol) -- Then all the rest that are letter digit or symbol
    let atom = first:rest -- Create our atom list
    return $ case atom of
        "#t" -> Bool True
        "#f" -> Bool False
        _    -> Atom atom

-- liftM tells Parser to just operate on the value in the monad
parseNumber :: Parser LispVal
parseNumber = liftM (Number . read) $ many1 digit

-- Does the symbol string contain the passed in char?
symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

-- Skip spaces
spaces :: Parser ()
spaces = skipMany1 space

parseString :: Parser LispVal
parseString = do
    char '"'
    x <- many (noneOf "\"") -- Similar to !string.Contains("...")
    char '"'
    return $ String x

parseExpression :: Parser LispVal
parseExpression = parseAtom <|> parseString <|> parseNumber

readExpression :: String -> String 
readExpression input = case parse (spaces >> symbol) "lisp" input of
    Left err -> "No Match: " ++ show err
    Right val -> "Found Value"
