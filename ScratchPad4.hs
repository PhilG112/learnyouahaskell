module ScratchPad4 (User (..), dummyUser, dummyUsers, SortBy (Age, Name),) where
import Data.Time
import Data.List

data SortBy = Age | Name

data User = User {
    name :: String,
    age :: Int,
    email :: String,
    registrationDate :: Day
} deriving (Eq, Show, Ord)

dummyUsers :: [User]
dummyUsers =
  [ User "Isaac Newton"    372 "isaac@newton.co.uk" (fromGregorian 1683  3 1)
  , User "Albert Einstein" 136 "ae@mc2.org"         (fromGregorian 1905 12 1)
  ]


dummyUser :: User
dummyUser =
    User "Albert Einstein" 136 "ae@mc2.org" (fromGregorian 1905 12 1)

users :: Maybe SortBy -> [User]
users Nothing = dummyUsers
users (Just s) = case s of
    Age -> sortOn age dummyUsers
    Name -> sortOn name dummyUsers