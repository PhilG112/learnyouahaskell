{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE ExtendedDefaultRules #-}
module Main where

import Web.Scotty ( param, get, scotty, post, text, ActionM, json, jsonData )
import Data.Aeson ( FromJSON, ToJSON )
import GHC.Generics ( Generic )
import Database.MongoDB ( (=:), Select (select), Document )
import Control.Monad.IO.Class (MonadIO (liftIO))
import qualified DataStore as DB
import qualified Data.Text.Lazy as T
import Data.Text hiding (head)
import Database.MongoDB.Connection
import qualified Data.Bson as B

main :: IO ()
main = do
    pipe <- connect $ host "127.0.0.1"
    scotty 3000 $ do

        get "/todo/:name" $ do
            name <- param "name"
            liftIO $ putStrLn name
            res <- DB.runQuery pipe (select ["firstName" =: name] "Test")
            json $ doc2User $ head res

        -- delete "/todo/:name" $ do
        --     text "Delete some user"

        post "/todo" $ do
            req <- jsonData :: ActionM User
            res <- liftIO $ DB.insertDoc ["firstName" =: firstName req, "lastName" =: lastName req]
            text v

data User = User
    { firstName :: String  
    , lastName :: String
    } deriving (Show, Generic)

instance ToJSON User
instance FromJSON User

doc2User :: Document -> User
doc2User doc = User
    { firstName = B.lookup "firstName" doc
    , lastName = B.lookup "lastName" doc
    }