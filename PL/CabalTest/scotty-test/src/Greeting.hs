{-# LANGUAGE OverloadedStrings #-}

module Greeting where

import Data.Monoid (mconcat)
import Data.Text.Lazy (Text)

data Language = English | Spanish
    deriving (Read)

greeting :: Language -> Text
greeting English = "Hello"
greeting Spanish = "Hola"

greet :: Text -> Language -> Text
greet name lang = mconcat [greeting lang, " ", name]