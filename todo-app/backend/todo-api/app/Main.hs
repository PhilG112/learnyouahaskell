{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
module Main where

import Web.Scotty ( delete, param, get, scotty, post, text, ActionM, json, jsonData, Parsable, status )
import Data.Aeson ( FromJSON, ToJSON )
import GHC.Generics ( Generic )
import Database.MongoDB ( (=:), Select (select), Document )
import Control.Monad.IO.Class (MonadIO (liftIO))
import qualified DataStore as DB
import qualified Data.Text.Lazy as T
import qualified Data.Text as DT
import qualified Data.Text.Internal
import Network.HTTP.Types.Status
import Data.Text hiding (head, map)
import Database.MongoDB.Connection
import Data.Bson
import Prelude hiding (lookup)
import GenericBson
import Data.Data (Typeable)
import Data.Text hiding (head)

main :: IO ()
main = do
    pipe <- connect $ host "127.0.0.1"
    scotty 3000 $ do

        get "/todo/:name" $ do
            name <- param "name"
            res <- liftIO $ DB.findByName name
            case res of
                Nothing -> status (mkStatus 404 "NotFound") --json $ NotFoundResponse ("No user found with name: " ++ name) 404
                Just a -> json (fromBSON a :: Maybe User)

        delete "/todo/:id" $ do
            oid <- param "id"
            liftIO $ DB.deleteDoc oid

        post "/todo" $ do
            req <- jsonData :: ActionM User
            res <- liftIO $ DB.insertDoc $ toBSON req
            json $ CreateUserResponse (show res)

data User = User
    { firstName :: String
    , lastName :: String
    } deriving (Show, Generic, Typeable, Eq)

newtype CreateUserResponse = CreateUserResponse
    { _id :: String
    } deriving (Generic)

data NotFoundResponse = NotFoundResponse
    { message :: String
    , code :: Int
    } deriving (Generic)

instance ToJSON CreateUserResponse
instance ToJSON NotFoundResponse

instance ToJSON User
instance FromJSON User
instance ToBSON User
instance FromBSON User
