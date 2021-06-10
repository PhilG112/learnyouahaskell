*Table of contents*

- [Types and Typeclasses](#types-and-typeclasses)
  - [Intro](#intro)
  - [Typeclasses 101](#typeclasses-101)

# Types and Typeclasses

## Intro

First type declaration

```hs
removeNonUppercase :: String -> String
removeNonUppercase st = [ c | c <- st, c `elem` ['A'...'Z']]
```

```hs
addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z
```

> The last item in the type declaration is the return type
> Use :t yourType to figure out the type

Common types

- Int 
- Integer
- Float
- Double
- Bool
- Char
- String

## Typeclasses 101

Type signature of ==:

```hs
:t (==)  
(==) :: (Eq a) => a -> a -> Bool  
```

> the => operator above acts as a constraint on type a. Where a must be a member of Eq (think of this as generic type constraints in c#).

Basic typeclasses:

Eq used for equality (== and /=)

Ord for types that have an ordering

Show will represent the type as a string (as long as the type is a member of show)

Read will try take a string and represent as a type e.g read "True" returns True (this of this something like int.TryParse in c#)

> Read doesn't auto know what type you want. You need to do something with the value so that it can return the correct type. E.g read "4" doesn't know that 4 is inherently an int, but it does know if you do read "4" + 4 = 8. You can also be explicit with the type when using read e.g read "4" :: Int, read "[1,2,3,4]" :: [Int], read "(3, 'a')" :: (Int, Char) 

Enum enumeration type. Sequentially ordered.

Bounded members have an upper and lower bound

```hs
minBound :: Int  
-2147483648  
maxBound :: Char  
'\1114111'  
maxBound :: Bool  
True  
minBound :: Bool  
False
```

> minBound and maxBound are interesting because they have a type of (Bounded a) => a. In a sense they are polymorphic constants.

Num is a numeric type

Integral is also a numeric typeclass. Num includes all numbers, including real numbers and integral numbers, Integral includes only integral (whole) numbers. In this typeclass are Int and Integer.

Floating includes only floating point numbers, so Float and Double.

fromIntegral type class with declartion `fromIntegral :: (Num b, Integral a) => a -> b`

> allows us to get different types of numbers to work together such as Int and Float e.g fromIntegral (length [1,2,3,4]) + 3.2
