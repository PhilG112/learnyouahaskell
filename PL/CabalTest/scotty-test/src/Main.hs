{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import Data.Monoid (mconcat)
import Greeting 


main :: IO ()
main = scotty 3000 $ do
    get "/:language/:name" $ do
        name <- param "name"
        languageStr <- param "language"
        let language = read languageStr
        html $ mconcat [ "<h1>", greet name language, "</h1>"]