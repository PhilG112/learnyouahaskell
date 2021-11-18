{-# LANGUAGE RecordWildCards #-}
module Mongolia.LookupTables where

import Prelude hiding (lookup)
import Data.Maybe

type Table k v = [(k, v)]

empty :: Table k v
empty = []

insert :: k -> v -> Table k v -> Table k v
insert k v t = (k,v) : t

delete :: Eq k => k -> Table k v -> Table k v
delete k [] = []
delete k ((k', v) : t)
    | k == k' = delete k t
    | otherwise = (k', v) : delete k t

delete' :: Eq k => k -> Table k v -> Table k v
delete' k [] = []
delete' k t = filter (\(k', _) -> k /= k') t

lookup :: Eq k => k -> Table k v -> Maybe v
lookup k [] = Nothing
lookup k ((k', v) : t)
    | k == k' = Just v
    | otherwise = lookup k t


---------------

type Amount = Int
type Account = String
type Accounts = Table Account Amount


-- data Transaction = Transaction Amount Account Account deriving (Eq, Show)

-- trAmount :: Transaction -> Amount
-- trAmount (Transaction a _ _ ) = a

-- trFrom :: Transaction -> Account
-- trFrom (Transaction _ f _) = f

-- trTo :: Transaction -> Account
-- trTo (Transaction _ _ t) = t

data Transaction = Transaction
    { trAmount :: Amount
    , trFrom :: Account
    , trTo :: Account
    } deriving (Eq, Show)

processTransaction :: Transaction -> Accounts -> Accounts
processTransaction Transaction{..} as =
    let
        fOld = fromMaybe 0 (lookup trFrom as)
        tOld = fromMaybe 0 (lookup trTo as)
    in
        insert trFrom (fOld - trAmount) (insert trTo (tOld + trAmount) as)