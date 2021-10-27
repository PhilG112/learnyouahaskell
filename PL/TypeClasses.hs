{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module PL.TypeClasses where

-- Type class instances
elem2 :: Eq t => t -> [t] -> Bool
elem2 a (x:xs)
    | a == x = True
    | otherwise = elem2 a xs

data RGB = RGB Int Int Int
    deriving (Show, Eq)

colors :: [RGB]
colors = [RGB 244 0 0, RGB 332 33 9]
green :: RGB
green = RGB 0 225 0

greenInColors :: Bool
greenInColors = elem2 green colors

-- Defining type Classes

data Point2 = Point2 Double Double deriving Show
data Point3 = Point3 Double Double Double deriving Show

distance2 :: Point2 -> Point2  -> Double
distance2 (Point2 x1 y1) (Point2 x2 y2) =
    sqrt (dx * dx + dy * dy)
    where
        dx = x1 - y1
        dy = x2 - y2

distance3 :: Point3 -> Point3 -> Double
distance3 (Point3 x1 y1 z1) (Point3 x2 y2 z2) =
    sqrt (dx * dx + dy * dy + dz * dz)
    where
        dx = x1 - y1
        dy = x2 - y2
        dz = z1 - z2

    -- The two functions below are identical 

lengthOfPath2 :: [Point2] -> Double
lengthOfPath2 [] = 0
lengthOfPath2 [_] = 0
lengthOfPath2 (p0:p1:ps) =
    distance2 p0 p1 + lengthOfPath2 (p1:ps)

lengthOfPath3 :: [Point3] -> Double
lengthOfPath3 [] = 0
lengthOfPath3 [_] = 0
lengthOfPath3 (p0:p1:ps) =
    distance3 p0 p1 + lengthOfPath3 (p1:ps)

    -- Think of class like a definition
class Measurable a where
    distance :: a -> a -> Double

    -- Think of instance like an instance of that class definition
instance Measurable Point2 where -- Define the function to use for Point2 types
    distance = distance2

instance Measurable Point3 where -- Define the function to use for Point3 Types
    distance = distance3

    -- Using Measurable (polymorphic function)
pathLength :: Measurable a => [a] -> Double
pathLength [] = 0
pathLength [_] = 0
pathLength (p0:p1:ps) =
    distance p0 p1 + pathLength (p1:ps) -- Automatically resolve which function to use based on the type of [a]

-- Subclasses
    -- Ord is a subclass of Eq

    -- Directions is now a subclass of Measureable and Show which means all types of a must be of those two type classes
class (Measurable a, Show a) => Directions a
    where
        getDirections :: a -> a -> String
        getDirections p1 p2 = -- This is a default implementation of the Directions class
            "Go From " ++ (show p1) ++
            " towards " ++ (show p2) ++
            " and stop after " ++ show (distance p1 p2)

instance Directions Point3 where
    getDirections p1 p2 =
        "Fly From " ++ (show p1) ++
        " towards " ++ (show p2) ++
        " and stop after " ++ show (distance p1 p2)

instance Directions Point2 where -- This doesn't define any definitions here so we will use the default getDirections implementation