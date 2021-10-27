module PL.IO where

main :: IO ()
main = putStrLn "Hello World"

-- do Blocks
mainDo :: IO ()
mainDo = do
    print "OK"
    print "WHY"

introduce :: String -> String -> IO ()
introduce name1 name2 = do
    print name1
    print name2

main2 :: IO ()
main2 = do
    introduce "bob" "alice"

-- IO Values
mainGet :: IO ()
mainGet = do
    line <- getLine
    print line

-- Return Function (lift an ordinary value to be an IO action)
dummyGetLine :: IO String
dummyGetLine = return "HAHA JEBAITED"

mainDummy :: IO ()
mainDummy = do
    line <- dummyGetLine
    print line

-- Basic IO Actions
    -- readFile (lazy)
    -- writeFile (write string to a file, lazy)
    -- appendFile (Append to end of file)
    -- interact (???)
reverseLines :: String -> String
reverseLines input = unlines (map reverse $ lines input)

mainR :: IO ()
mainR = interact reverseLines