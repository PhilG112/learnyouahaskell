module PL.CustomTypes where
import PL.CustomTypes (Customer(MakeCustomer))

-- Type synonyms
    -- A new name for something (alias)
    -- Make code more readable
type String = [Char]
type Point = (Double, Double)

midpoint :: Point -> Point -> Point
midpoint (x1, y1) (x2, y2) = ((x1 + x2) / 2, (y1 +y2) / 2)

-- New type
    -- Synonym for a type which is not interchangeable
 
    -- In this case MakeCustomerId is the constructor name
newtype CustomerId = MakeCustomerId Int

    -- Here you must use the constructor to create a new CustomerId
customer :: CustomerId
customer = MakeCustomerId 13

customerToInt :: CustomerId -> Int 
customerToInt (MakeCustomerId i) = i

-- Records
    -- Type with named fields
    -- Not extensible
    -- No heirachy
    -- NO field names in multiple record types
    -- Use algebraic data types instead (mostly)

data Customer = MakeCustomer
    { customerId :: CustomerId
    , name :: String 
    , luckyNumber :: Int 
    }

-- Algebraic data types
    -- Used everywhere

data Customer2 = Customer2 CustomerId String Int

alice2 :: Customer2
alice = Customer2 (CustomerId 13) "Alice" 42

getAlice :: Customer -> CustomerId
getAlice (Customer2 id name luckyNumber) = id

    -- String Tree (Recursive)
data StringTree = StringTree String [StringTree]

hierarchy = StringTree "C:"
    [ StringTree "ProgramFiles" []
    , StringTree "Users" [StringTree "Alice" []]
    , StringTree "Cats" []
    ]

-- Algebraic data types Constructors
    -- Constructors seperated with |
data Bool = False | True

    -- Similar to Enums
data DialogResponse = Yes | No | Help | Quit

data MaybeInt = NoInt | JustInt Int
defaultInt :: Int -> MaybeInt -> Int 
defaultInt defaultValue NoInt = defaultValue
defaultInt _ (JustInt x) = x

data StringList = EmptyStringList
               | ConsStringList String StringList

lengthStringList :: StringList -> Int 
lengthStringList EmptyStringList = 0
lengthStringList (ConsStringList _ xs) = length xs + 1

-- Parameterized Types
    -- Generic types in C#

    -- a is the type of T
data Maybe a = Just a | Nothing 

x :: Maybe Int
x = Nothing

fromMaybe :: a -> Maybe a -> a
fromMaybe defaultVal Nothing = defaultVal
fromMaybe _ (Just x) = x -- Just constructor

