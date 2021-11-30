module Mongolia.FunctionalProgrammingWithIO where
import Prelude hiding (sequence)
import GHC.IO.Handle
import System.IO

ask :: String -> IO String
ask s = do
    putStrLn s
    getLine

askMany :: [String] -> IO [String]
askMany [] = return []
askMany (x:xs) = do
    answer <- ask x
    answers <- askMany xs
    return (answer:answers)

-- askMany looks like map but we cannot use map because it gives the wrong result type
-- Instead we use sequence below
-- THis is almost like in c# var myTasks = new List<Task>(); Task.WaitAll(myTasks);
-- Collect a list of actions and execute them all with their results in a list

sequence :: [IO a] -> IO [a]
sequence [] = return []
sequence (x:xs) = do
    a <- x
    as <- sequence xs
    return (a:as)

askMany' :: [String] -> IO [String]
askMany' = sequence . map ask

askMany'' :: [String] -> IO [String]
askMany'' = mapM ask

-- Traversing a tree interactivley
-- A tree of yes-no questions
data Interaction = Question String Interaction Interaction | Result String
    deriving (Show)

pick :: Interaction
pick = Question
    "Do you like FP"
    (Question
        "Ddo you like static Types"
        (Result "Try Haskell")
        (Result "Try clojure"))
    (Question
        "Do you like dynamic Types"
        (Result "Try python")
        (Result "Try javascript"))

askQuestion :: String -> IO Bool
askQuestion q = do
    putStrLn (q ++ " [y/n]")
    yn <- getChar
    putStrLn ""
    return (yn `elem` "yY")

interaction :: Interaction -> IO String
interaction (Result r) = return r
interaction (Question q y n) = do
    b <- askQuestion q
    if b 
        then interaction y
        else interaction n
         
simulate :: Interaction -> [Bool] -> Maybe String
simulate (Result r) [] = Just r
simulate (Question _ y n) (x:xs)
    | x = simulate y xs
    | otherwise = simulate n xs


-- Handles files, resources
readFileLineByLine :: FilePath -> IO [String]
readFileLineByLine file = withFile file ReadMode readFileHandle

readFileHandle :: Handle -> IO [String]
readFileHandle h = do
    eof <- hIsEOF h
    if eof
        then return []
        else do
            line <- hGetLine h
            lines <- readFileHandle h
            return (line:lines)