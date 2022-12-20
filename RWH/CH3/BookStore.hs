module RWH.CH3.BookStore where

type BookId = Int

data BookInfo = Book BookId String [String] deriving (Show)

data MagazineInfo = Magazine Int String [String] deriving (Show)

type CustomerId = Int
type ReviewBody = String

data BookReview = BookReview BookInfo CustomerId ReviewBody

type BookRecord = (BookInfo, BookReview)

myInfo :: BookInfo
myInfo = Book 12345 "MyBookName" ["SR1", "SR2"]

type CardHolder = String
type CardNumber = String
type Address = [String]

data BillingInfo = CreditCard CardNumber CardHolder Address
                | CashOnDelivery
                | Invoice CustomerId
                deriving (Show)

data Customer = Customer {
     customerId :: CustomerId
    , customerName :: String
    , customerAddress :: Address
} deriving (Show)

turnListPalindrome :: [a] -> [a]
turnListPalindrome [] = []
turnListPalindrome arr = arr ++ reverse arr