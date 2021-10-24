{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Main where

import Text.ParserCombinators.Parsec hiding (spaces)
import System.Environment
import Control.Monad
import GHC.ResponseFile (escapeArgs)
import Numeric

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
             | Character Char
             | Float Float

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
parseNumber = parseDecimal1 <|> parseDecimal2 <|> parseHex <|> parseOct <|> parseBin

parseCharacter :: Parser LispVal
parseCharacter = do
    try $ string "#\\"
    value <- try (string "newline" <|> string "space") <|> do
        x <- anyChar 
        notFollowedBy alphaNum 
        return [x]
    return $ Character $ case value of
        "space" -> ' '
        "newline" -> '\n'
        _ -> head value
    
parseFloat :: Parser LispVal
parseFloat = do
    x <- many1 digit -- Match many numbers
    char '.' -- Then match a dot
    y <- many1 digit -- Then match all numbers after that 
    return $ Float (fst . head $ readFloat (x ++ "." ++ y)) -- Concat both sides of the float together. readFloat returns a list of pairs of possible matches hence fst . head $ ..

parseDecimal1 :: Parser LispVal
parseDecimal1 = many1 digit >>= (return . Number . read) -- bind the result of many1 digit to the return function

-- if an error occurs try acts like nothing has happened
parseDecimal2 :: Parser LispVal
parseDecimal2 = do
    try $ string "#d"
    x <- many1 digit
    (return . Number . read) x

parseHex :: Parser LispVal
parseHex = do
    try $ string "#x"
    x <- many1 hexDigit
    return $ Number (hex2dig x)
    where
        hex2dig h = fst $ head (readHex h)

parseOct :: Parser LispVal
parseOct = do
    try $ string "#o"
    x <- many1 octDigit
    return $ Number (oct2dig x)
    where
        oct2dig o = fst $ head (readOct o)

parseBin :: Parser LispVal
parseBin = do
    try $ string "#b"
    x <- many1 (oneOf "10")
    return $ Number (bin2dig x)

bin2dig :: [Char] -> Integer
bin2dig = bin2dig' 0

bin2dig' :: Num t => t -> [Char] -> t
bin2dig' digint "" = digint
bin2dig' digint (x:xs) =
    let old = 2 * digint + (if x == '0' then 0 else 1)
    in bin2dig' old xs

-- parseNumber with do notation
parseNumber2 :: Parser LispVal
parseNumber2 = do
    d <- many1 digit
    (return . Number . read) d

-- parseNumber with lambda notion
parseNumber3 :: Parser LispVal
parseNumber3 = many1 digit >>= (\d -> (return . Number . read) d)

-- Does the symbol string contain the passed in char?
symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

-- Skip spaces
spaces :: Parser ()
spaces = skipMany1 space

parseString :: Parser LispVal
parseString = do
    char '"'
    x <- many $ escapedChars <|> noneOf "\"" -- Similar to !string.Contains("...")
    char '"'
    return $ String x

parseBool :: Parser LispVal
parseBool = do
    char '#'
    (char 't' >> return (Bool True)) <|> (char 'f' >> return (Bool False))

escapedChars :: Parser Char
escapedChars = do
    char '\\' -- Match a backslash
    c <- oneOf "\\\"nrt" -- is the supplied character within the string?
    return $ case c of -- Switch on the result of C to return the correct escaped character
        '\\' -> c
        '"' -> c
        't' -> '\t'
        'r' -> '\r'
        'n' -> '\n'

parseExpression :: Parser LispVal
parseExpression = parseAtom
    <|> parseString
    <|> parseNumber
    <|> parseBool
    <|> parseCharacter

readExpression :: String -> String
readExpression input = case parse (spaces >> symbol) "lisp" input of
    Left err -> "No Match: " ++ show err
    Right val -> "Found Value"
