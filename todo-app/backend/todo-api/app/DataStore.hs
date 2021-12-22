{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
module DataStore where

import Database.MongoDB
import Data.Text hiding (find)
import Web.Scotty
import Control.Monad.Cont

data UserEntity = UserEntity
    { _id :: Text
    , firstName :: Text
    , lastName :: Text
    }

runQuery :: Pipe -> Query -> ActionM (Maybe Document)
runQuery p q = access p master "Test" (findOne q)

insertDoc :: Document -> IO Value
insertDoc doc = run $ insert "Test" doc

run :: MonadIO m => Action m a -> m a 
run action = do
    pipe <- liftIO $ connect $ host "127.0.0.1"
    access pipe master "data" action

-- getUser :: String -> Action IO (Maybe Document)
-- getUser s = findOne (select ["firstName" =: s] "Test")

-- deleteUser :: _

-- insertUser :: _
