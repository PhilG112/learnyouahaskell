{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Tutorial where

-- https://docs.servant.dev/en/stable/tutorial/ApiType.html

import Data.Text
import Data.Time (UTCTime)
import Servant.API

-- GET: /users?sortBy={age|name}
-- Return list of Users

type UserApi = "users"
    :> QueryParam "sortBy" SortBy
    :> Get '[JSON] [User]

type RootEndpointExample = Get '[JSON] User

-- Describes an endpoint /users/list-all/now which returns a list of users 
type UserApi2 = "users"
    :> "list-all"
    :> "now" 
    :> Get '[JSON] [User]

data SortBy = Age | Name

data User = User {
    name :: String,
    age :: Int,
    email :: String,
    registrationDate :: UTCTime
}

-- Captures

-- GET: /user/{userId}
-- Explicit in userId being an Integer
-- Second endpoint is the same but for delete
type UserApi3 = 
        "user"
        :> Capture "userId" Integer
        :> Get '[JSON] User
    :<|> "user"
        :> Capture "userId" Integer
        :> DeleteNoContent

-- QueryParam, QueryParams, QueryFlag

-- ReqBody

-- This is POST: /users with a JSON object in the req body
-- Returns a User encoded in JSON
-- Putting with a userId
type UserApi4 =
        "users"
        :> ReqBody '[JSON] User
        :> Post '[JSON] User
    :<|> "users" 
        :> Capture "userId" Integer
        :> ReqBody '[JSON] User
        :> Put '[JSON] User         

-- Request Headers

type UserApi5 = "users"
    :> Header "User-Agent" Text
    :> Get '[JSON] [User]

-- Content Types

-- Supported out of the box content types, you can allow an endpoint to accept all 4. You can also define your own.
type UserAPI9 = "users"
    :> Get '[JSON, PlainText, FormUrlEncoded, OctetStream] [User]

-- Response Headers

-- If you want to describe an endpoint that returns a “User-Count” header in each response, you could write it as below:
type UserAPI10 = "users"
    :> Get '[JSON] (Headers '[Header "User-Count" Integer] [User])


-- Basic Auth

type ProtectedApi1 =
    UserAPI10
    :<|> BasicAuth "protected-endpoint" User :> UserApi2