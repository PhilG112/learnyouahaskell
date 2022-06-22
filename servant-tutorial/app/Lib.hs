{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Lib where

import Data.Text
import Data.Time (UTCTime)
import Servant.API

-- GET: /users?sortBy={age|name}
-- Return list of Users

type UserApi = "users"
    :> QueryParam "sortBy" SortBy
    :> Get '[JSON] [User]

data SortBy = Age | Name

data User = User {
    name :: String,
    age :: Int,
    email :: String,
    registrationDate :: UTCTime
}
