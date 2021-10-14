{-# LANGUAGE BlockArguments #-}
-- https://en.wikibooks.org/wiki/Write_Yourself_a_Scheme_in_48_Hours/Parsing

module Main where
import System.Environment
import Text.ParserCombinators.Parsec hiding (spaces)
import Control.Monad
import Data.Text.Internal.Read (digitToInt)

-- -- Take two num args and add them
-- main :: IO ()
-- main = do
--     args <- getArgs
--     print (show (read (args !! 0) +  read (args !! 1)))

main :: IO ()
main = do
    (expr:_) <- getArgs
    print $ readExpr expr

data LispVal = Atom String
             | List [LispVal]
             | DottedList [LispVal] LispVal
             | Number Integer
             | String String
             | Bool Bool

parseAtom :: Parser LispVal
parseAtom = do
    first <- letter <|> symbol
    rest <- many (letter <|> digit <|> symbol)
    let atom = first:rest
    return $ case atom of
        "#t" -> Bool True
        "#f" -> Bool False
        _    -> Atom atom

symbol :: Parser Char
symbol = oneOf "!#$%&|*+-/:<=>?@^_~"

parseBool :: Parser LispVal
parseBool = do
    char '#'
    (char 't' >> return (Bool True)) <|> (char 'f' >> return (Bool False))

parseString :: Parser LispVal
parseString = do
    char '"'
    x <- many $ parseEscapedChars <|> noneOf "\""
    char '"'
    return $ String x

parseEscapedChars :: Parser Char 
parseEscapedChars = do char '\\'
                       x <- oneOf "\\\"nrt"
                       return $ case x of
                           '\\' -> x
                           '"' -> x
                           'n' -> '\n'
                           't' -> '\t'
                           'r' -> '\r'

parseNumber :: Parser LispVal
parseNumber = parseDecimal1 <|> parseDecimal2 <|> parseHex <|> parseOct <|> parseBin

parseDecimal1 :: Parser LispVal
parseDecimal1 = many1 digit >>= (return . Number . read)

parseDecimal2 :: Parser LispVal
parseDecimal2 = do try $ string "#d"
                   x <- many1 digit
                   (return . Number . read) x

parseHex :: Parser LispVal
parseHex = do try $ string "x"
              x <- many1 octDigit
              return $ Number (oct2dig x)

parseBin :: Parser LispVal
parseBin = do try $ string "#b"
              x <- many1 (oneOf "10")
              return $ Number (bin2dig x)

oct2dig :: t -> a
oct2dig x = fst $ readOct x !! 0

hex2dig :: t -> a
hex2dig x = fst $ readHex x !! 0

bin2dig :: [Char] -> Integer
bin2dig = bin2dig' 0

bin2dig' :: Num t => t -> [Char] -> t
bin2dig' digint "" = digint
bin2dig' digint (x:xs) = let old = 2 * digint + (if x == '0' then 0 else 1) in
                         bin2dig' old xs


spaces :: Parser ()
spaces = skipMany1 space

parseExpr :: Parser LispVal
parseExpr = parseAtom <|> parseString <|> parseNumber

readExpr :: String -> String
readExpr input = case parse parseExpr "Lisp" input of
    Left err -> "No match " ++ show err
    Right val -> "Found value"