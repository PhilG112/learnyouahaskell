*Table of contents*

- [Recursion](#recursion)
  - [Maximum function](#maximum-function)
    - [Replicate](#replicate)
  - [Take](#take)
  - [Reverse](#reverse)
  - [Zip](#zip)
  - [elem](#elem)
  - [Quick sort](#quick-sort)

# Recursion

Recursion is important to Haskell because unlike imperative languages, you do computations in Haskell by declaring what something is instead of declaring how you get it. That's why there are no while loops or for loops in Haskell and instead we many times have to use recursion to declare what something is.

## Maximum function

The maximum function takes a list of things that can be ordered (e.g. instances of the Ord typeclass) and returns the biggest of them.

```hs
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "empty list"
maximum' [x] = x
maximum' (x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = maximum' xs
```

> The above is not optimised for tail call recursion

Other better implementations:

```hs
-- 1.
maxlist [] = (error "Empty list")
maxlist xs = rec xs res
    where rec [] res = res
          rec (x:xs) rec = rec xs (max x res)

-- 2.
maxlist2 (x:xs) = fold max x xs
```

### Replicate

`replicate 3 5` returns [5,5,5]

Recursive replicate example:

```hs
replicate' :: (Num i, Ord i) => i -> a -> [a]  
replicate' n x
    | n <= 0    = []  
    | otherwise = x:replicate' (n-1) x
```

## Take

It takes a certain number of elements from a list. For instance, `take 3 [5,4,3,2,1]` will return [5,4,3]

```hs
take' :: (Num i, Ord i) => i -> [a] -> [a]  
take' n _  
    | n <= 0   = []  -- If n is less than or == 0 return empty list
take' _ []     = []  -- If the list is empty then return the empty list. We use underscore here because we don't care about n
take' n (x:xs) = x : take' (n-1) xs -- Split list into head:tail 
```

**Haskell -> C#**

Map = Select
Reduce = Aggregate
Where = Where

## Reverse

```hs
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]
```

## Zip

```hs
zip' :: [a] -> [b] -> [(a,b)] -- Definition
zip' _ [] = [] -- If second list is empty return empty
zip' [] _ = [] -- If first list is empty return empty
zip' (x:xs) (y:ys) = (x,y):zip' xs ys
```

## elem

```hs
elem' :: (Eq a) => a -> [a] -> Bool -- Definition
elem' a [] = False -- If list is empty return false
elem' a (x:xs)  
    | a == x    = True -- If a is equal to head return true
    | otherwise = a `elem'` xs -- else call elem with a and  the tail and repeat until we get a result
```

## Quick sort

```hs
quicksort :: (Ord a) => [a] -> [a] -- Definition
quicksort [] = [] -- Edge case, empty list returns empty list
quicksort (x:xs) =  
    let smallerSorted = quicksort [a | a <- xs, a <= x] -- List comp where a <= x
        biggerSorted = quicksort [a | a <- xs, a > x] -- List comp where a > x
    in  smallerSorted ++ [x] ++ biggerSorted -- See note below
```

> When you see let A in B you can think of B as the value of the statement. In an imperative language, you might write it as A; return B.

