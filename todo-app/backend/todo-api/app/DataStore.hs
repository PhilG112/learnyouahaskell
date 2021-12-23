{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
module DataStore 
( findByName
, insertDoc
, deleteDoc
) where

import Database.MongoDB
import Data.Text hiding (find)
import Web.Scotty hiding (delete)
import Control.Monad.Cont

data UserEntity = UserEntity
    { _id :: Text
    , firstName :: Text
    , lastName :: Text
    }

findByName :: String -> IO (Maybe Document)
findByName name = run (findOne (select ["firstName" =: name] "Test"))

insertDoc :: Document -> IO Value
insertDoc doc = run $ insert "Test" doc

deleteDoc :: String -> IO ()
deleteDoc id = run $ delete (select ["_id" =: ObjId (read id :: ObjectId)] "Test")

run :: MonadIO m => Action m a -> m a 
run action = do
    pipe <- liftIO $ connect $ host "127.0.0.1"
    access pipe master "Test" action
