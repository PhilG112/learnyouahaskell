*Table of contents*

- [Recursion](#recursion)
  - [Maximum function](#maximum-function)
    - [Replicate](#replicate)
  - [Take](#take)

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

Map = Select
Aggregate = Reduce
Where = Where