{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE ExtendedDefaultRules #-}
module Main where

import Web.Scotty
import Data.Aeson (ToJSON, FromJSON)
import GHC.Generics
import Database.MongoDB
import Control.Monad.IO.Class

main :: IO ()
main = do
    putStrLn "Starting Server..."
    scotty 3000 $ do
        get "/hello/:name"$ do
            p <- param "name"
            hello p

data User = User
    { userName :: String 
    , lastName :: String
    } deriving (Show, Generic)

instance ToJSON User
instance FromJSON User

hello :: String -> ActionM ()
hello n = do
    docs <- liftIO $ run $ getByFirstName n
    json $ User {userName="Bob", lastName="Smith"}

run :: MonadIO m => Action m a -> m a 
run action = do
        pipe <- liftIO(connect $ host "127.0.0.1")
        access pipe master "Test" action

insertDoc :: Document -> Action IO Value
insertDoc d = insert "Test" d

getByFirstName :: String -> Action IO [Document]
getByFirstName s = run $ rest =<< find (select ["firstName" =: s] "Test")
