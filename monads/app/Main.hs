{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Data.Aeson
import Data.Time
import GHC.Generics
import Network.Wai.Handler.Warp
import Servant (Application, Capture, Get, Handler, JSON, Proxy (Proxy), serve, (:>))
import Servant.Server (Server)

main :: IO ()
main = do
    putStrLn "Hello, Haskell!"
    run 8081 app1

server1 :: Server UserAPI1
server1 = return users1

type API = "position" :> Capture "x" Int :> Capture "y" Int :> Get '[JSON] Position

server2 :: Server API
server2 = positionHandler

positionHandler :: Int -> Int -> Handler Position
positionHandler x y = return (Position x y)

userAPI :: Proxy UserAPI1
userAPI = Proxy

-- 'serve' comes from servant and hands you a WAI Application,
-- which you can think of as an "abstract" web application,
-- not yet a webserver.
app1 :: Application
app1 = serve userAPI server1

type UserAPI1 = "users" :> Get '[JSON] [User]

data Position = Position
    { xCoord :: Int
    , yCoord :: Int
    }
    deriving (Generic)

instance ToJSON Position

data User = User
    { name :: String
    , age :: Int
    , email :: String
    , registration_date :: Day
    }
    deriving (Eq, Show, Generic)

instance ToJSON User

users1 :: [User]
users1 =
    [ User "Isaac Newton" 372 "isaac@newton.co.uk" (fromGregorian 1683 3 1)
    , User "Albert Einstein" 136 "ae@mc2.org" (fromGregorian 1905 12 1)
    ]
