{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
module Main where

import Control.Monad.IO.Class
import Database.MongoDB

main :: IO ()
main = do
    pipe <- connect $ host "127.0.0.1"
    e <- access pipe master "Test" run
    close pipe
    print e

-- run :: MonadIO m => Action m a -> m a 
run :: Action IO Value
run = do
    getByFirstName "Bob" >>= printDocs "Bobby"
    insertDoc

insertDoc :: Action IO Value
insertDoc = insert "Test" ["firstName" =: "Jane", "lastName" =: "Doe"]

getByFirstName :: String -> Action IO [Document]
getByFirstName s = rest =<< find (select ["firstName" =: s] "Test")

printDocs :: String -> [Document] -> Action IO ()
printDocs title docs = liftIO $ putStrLn title >> mapM_ (print . exclude ["_id"]) docs