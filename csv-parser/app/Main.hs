{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Main
  ( Item(..)
  , ItemType(..)
  , decodeItems
  , decodeItemsFromFile
  , encodeItems
  , encodeItemsToFile
  , filterCountryItems
  , itemHeader
  , japanItem
  , japanRecord
  )
  where

-- base
import Control.Exception (IOException)
import qualified Control.Exception as Exception
import qualified Data.Foldable as Foldable

-- bytestring
import Data.ByteString.Lazy (ByteString)
import qualified Data.ByteString.Lazy as ByteString

-- cassava
import Data.Csv
  ( DefaultOrdered(headerOrder)
  , FromField(parseField)
  , FromNamedRecord(parseNamedRecord)
  , Header
  , ToField(toField)
  , ToNamedRecord(toNamedRecord)
  , (.:)
  , (.=)
  )
import qualified Data.Csv as Cassava

-- text
import Data.Text (Text)
import qualified Data.Text.Encoding as Text

-- vector
import Data.Vector (Vector)
import qualified Data.Vector as Vector

main :: IO ()
main = 3
-- title,score,id,url,comms_num,created,body,timestamp
data Item =
  Item
    { title :: Text
    , score :: Int
    , id :: Text
    , url :: Text
    , nomOfComments :: Int
    , createdAt :: Text
    , body :: Text
    , timestamp :: DateTime
    }
  deriving (Eq, Show)

instance FromNamedRecord Item where
  parseNamedRecord =
    Item
      <*> m .: "title"
      <*> m .: "score"
      <*> m .: "id"
      <*> m .: "comms_num"
      <*> m .: "created"
      <*> m .: "body"
      <*> m .: "timestamp"