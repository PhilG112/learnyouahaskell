{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE ExtendedDefaultRules #-}
module Main where

import Web.Scotty ( param, get, scotty, post, text, ActionM, json, jsonData, Parsable )
import Data.Aeson ( FromJSON, ToJSON )
import GHC.Generics ( Generic )
import Database.MongoDB ( (=:), Select (select), Document )
import Control.Monad.IO.Class (MonadIO (liftIO))
import qualified DataStore as DB
import qualified Data.Text.Lazy as T
import qualified Data.Text as DT
import qualified Data.Text.Internal
import Data.Text hiding (head, map)
import Database.MongoDB.Connection
import Data.Bson
import Prelude hiding (lookup)
import GenericBson
import Data.Data (Typeable)
import Data.Text

main :: IO ()
main = do
    pipe <- connect $ host "127.0.0.1"
    scotty 3000 $ do

        get "/todo/:name" $ do
            name <- param "name"
            liftIO $ putStrLn name
            res <- DB.runQuery pipe (select ["firstName" =: name] "Test")
            case res of
                Nothing -> text "Not found"
                Just a -> json $ (fromBSON a :: Maybe User)
            liftIO $ putStrLn (B.lookup "firstName" (head res))
            text $ T.pack $ show $ head res
            -- json $ doc2User $ head res

        -- delete "/todo/:name" $ do
        --     text "Delete some user"

        post "/todo" $ do
            req <- jsonData :: ActionM User
            liftIO $ putStrLn $ show $ toBSON req
            res <- liftIO $ DB.insertDoc $ toBSON req
            text $ T.pack $ show res
            text ""

data User = User
    { firstName :: String
    , lastName :: String
    } deriving (Show, Generic, Typeable, Eq)

instance ToJSON User
instance FromJSON User
instance ToBSON User
instance FromBSON User