*Table of contents*
- [Syntax in functions](#syntax-in-functions)
  - [Pattern matching](#pattern-matching)
    - [x:xs](#xxs)
    - [As patterns](#as-patterns)
    - [Guards](#guards)
    - [Where operator](#where-operator)
    - [Let it be](#let-it-be)
    - [Case expressions](#case-expressions)

# Syntax in functions

## Pattern matching

When defining functions, you can define separate function bodies for different patterns. This leads to really neat code that's simple and readable. You can pattern match on any data type.

```hs
lucky :: (Integral a) => a -> String  
lucky 7 = "LUCKY NUMBER SEVEN!"  
lucky x = "Sorry, you're out of luck, pal!"
```

> The above will match the parameter it is used with. If 7 is passed it will output the first string. Anything other than seven will fall through to x and output Sorry.

```hs
sayMe :: (Integral a) => a -> String  
sayMe 1 = "One!"  
sayMe 2 = "Two!"  
sayMe 3 = "Three!"  
sayMe 4 = "Four!"  
sayMe 5 = "Five!"  
sayMe x = "Not between 1 and 5"
```

Implementing factorial recursively with pattern matching

```hs
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)
```

> Pattern matching can fail if the function is called with an unexpected input without a catch-all pattern. Similar to a unsupported value in a c# switch statement.

Pattern matching tuples

Without pattern matching:

```hs
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a) -- Definition
addVectors a b = (fst a + fst b, snd a + snd b) -- Add the vectors
```

With pattern matching:

```hs
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a) -- Definition
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2) -- Matches on two tuples with x and y values
```

Pattern matching with triples:

```hs
first :: (a, b, c) -> a  
first (x, _, _) = x  
  
second :: (a, b, c) -> b  
second (_, y, _) = y  
  
third :: (a, b, c) -> c  
third (_, _, z) = z  
```

Pattern matching with list comprehension

```hs
let xs = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)] -- List of tuples
[a+b | (a,b) <- xs]  
[4,7,6,8,11,4]   
```

### x:xs

x:xs represent a list which x is the first element (head) and xs is the rest of the list (tail).

This pattern is commonly found in pattern matching of a function that has list as argument along with [] (empty list).

```hs
sum :: [Int] -> Int -- Take a list and return an Int 
sum [] = 0 -- Empty list returns 0
sum (x:xs) = x + sum xs -- one more element then add the head (x) with the tail (xs)
```

> Example x:y:z:zs will bind the first 3 elements of a list to x,y,z and the tail to zs (will match only on lists with 3 or more elements)

Example of custom head' function:

```hs
head' :: [a] -> a  -- Definition, take list return list element
head' [] = error "Can't call head on an empty list, dummy!" -- Can't take [0] on empty list
head' (x:_) = x -- Return head element and ignore the rest

head' [4,5,6] -- returns 4
```

Futher understanding with trivial function:

```hs
tell :: (Show a) => [a] -> String -- Definition. Take a list of sometype that is a member of the show typeclass
tell [] = "The list is empty"  
tell (x:[]) = "The list has one element: " ++ show x  
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y  
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y
```

Length function with pattern matching and recursion:

```hs
length' :: (Num b) => [a] -> b  -- Definition. Take list of a return b where b is a member of the Num typeclass
length' [] = 0  -- return 0 for empty lists
length' (_:xs) = 1 + length' xs -- 1 + tail
```

Sum with pattern matching and recursion:

```hs
sum' :: (Num a) => [a] -> a  -- Definition
sum' [] = 0  -- Empty list returns 0
sum' (x:xs) = x + sum' xs -- head + sum of tail
```

### As patterns

Breaking something up according to a pattern and binding it to names whilst still keeping a reference to the whole thing.

Example `xs@(x:y:ys)` This pattern will match `x:y:ys` but you can how easily reference the whole list via `xs`, example:

```hs
capital :: String -> String -- Definition
capital "" = "Empty string, whoops!" -- Empty string match
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x] -- Notice how we reference all again which is a reference to the whole list but still access the head via x
```

> One more thing — you can't use ++ in pattern matches. If you tried to pattern match against (xs ++ ys), what would be in the first and what would be in the second list? It doesn't make much sense. It would make sense to match stuff against (xs ++ [x,y,z]) or just (xs ++ [x]), but because of the nature of lists, you can't do that.

### Guards

Whereas patterns are a way of making sure a value conforms to some form and deconstructing it, guards are a way of testing whether some property of a value (or several of them) are true or false. That sounds a lot like an if statement and it's very similar. The thing is that guards are a lot more readable when you have several conditions and they play really nicely with patterns. Basically succinct if statements.

BMI function:

```hs
bmiTell :: (RealFloat a) => a -> String  
bmiTell bmi  
    | bmi <= 18.5 = "You're underweight, you emo, you!"  
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"  
    | otherwise   = "You're a whale, congratulations!"
```

> Guards vs Patterns: Pattern checks if an input satisfies a pattern whereas guards check for bool conditions.

> If no suitable guards or patterns are found, an error is thrown.

```hs
bmiTell :: (RealFloat a) => a -> a -> String  -- Definition
bmiTell weight height  
    | weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"  
    | weight / height ^ 2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"  
    | otherwise                 = "You're a whale, congratulations!"
```

> Take multiple parameters to calculate the BMI for a user.

More examples:

```hs
max' :: (Ord a) => a -> a -> a  -- Definition
max' a b   
    | a > b     = a  -- First guard
    | otherwise = b  -- Second guard
```

And a two liner:

```hs
max' :: (Ord a) => a -> a -> a  
max' a b | a > b = a | otherwise = b
```

> Good practice to put your guards on separate lines as it is more readable.

Custom compare using guards:

```hs
myCompare :: (Ord a) => a -> a -> Ordering  -- Definition
a `myCompare` b  -- myCompare is an infix function
    | a > b     = GT  
    | a == b    = EQ  
    | otherwise = LT
```

> Note: Not only can we call functions as infix with backticks, we can also define them using backticks. Sometimes it's easier to read that way.

### Where operator

Bmi calculation with where:

```hs
bmiTell :: (RealFloat a) => a -> a -> String  
bmiTell weight height  
    | bmi <= 18.5 = "You're underweight, you emo, you!"  
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"  
    | otherwise   = "You're a whale, congratulations!"  
    where bmi = weight / height ^ 2 -- Instead of repeating this in each guard we do it once here.
```

BMI Further!

```hs
bmiTell :: (RealFloat a) => a -> a -> String  
bmiTell weight height  
    | bmi <= skinny = "You're underweight, you emo, you!"  
    | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | bmi <= fat    = "You're fat! Lose some weight, fatty!"  
    | otherwise     = "You're a whale, congratulations!"  
    where bmi = weight / height ^ 2 -- We now define all variables after the where
          skinny = 18.5  
          normal = 25.0  
          fat = 30.0  -- This can also be defined as (skinny, normal, fat) = (18.5, 25.0, 30.0)  as a pattern match
```

Getting initials:

```hs
initials :: String -> String -> String  -- Definition
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."  -- Concat the initials
    where (f:_) = firstname  -- Get head bind to f
          (l:_) = lastname  -- Get head bing to l
```

Another BMI:

```hs
calcBmis :: (RealFloat a) => [(a, a)] -> [a]  -- Take a list of tuples return a list of a
calcBmis xs = [bmi w h | (w, h) <- xs]  -- input = [whereFunction w h | (w, h) , <- input]
    where bmi weight height = weight / height ^ 2 -- define bmi function in the where clause
```

The above could also be written as:

```hs
calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [w / h ^ 2 | (w, h) <- xs]
```

### Let it be

let bindings let you bind to variables anywhere and are expressions themselves. Their scope is more local and cannot be seen by guards whereas where clauses can be.

Cylinder surface:

```hs
cylinder :: (RealFloat a) => a -> a -> a  
cylinder r h = 
    let sideArea = 2 * pi * r * h  
        topArea = pi * r ^2  
    in  sideArea + 2 * topArea
```

> let <bindings> in <expression> - the names defined in let are accessible to the scope of in.

`4 * (let a = 9 in a + 1) + 2` you can see that let is used as an expression. This will return 42.

They can also be used to introduce functions in a local scope:

```hs
[let square x = x * x in (square 5, square 3, square 2)]  
-- returns [(25,9,4)]
```

If we want to bind to several variables inline, we obviously can't align them at columns. That's why we can separate them with semicolons.

```hs
(let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar)  
-- returns (6000000,"Hey there!")
```

Pattern match with let bindings:

`(let (a,b,c) = (1,2,3) in a+b+c) * 100` returns 600

Bmi again:

```hs
calcBmis :: (RealFloat a) => [(a, a)] -> [a]  
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2] -- You can define your predicate as a function then use that? Nice
```

Bmi again with let + regular predicate

```hs
calcBmis :: (RealFloat a) => [(a, a)] -> [a]  
-- name param = [bmi | input, let expression, predicate]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2, bmi >= 25.0]
```

> If let bindings are so cool, why not use them all the time instead of where bindings, you ask? Well, since let bindings are expressions and are fairly local in their scope, they can't be used across guards. Some people prefer where bindings because the names come after the function they're being used in. That way, the function body is closer to its name and type declaration and to some that's more readable.

### Case expressions

Taking a variable and then executing blocks of code for specific values of that variable and then maybe including a catch-all block of code in case the variable has some value for which we didn't set up a case.

The following two functions are the same:

```hs

-- 1.
head' :: [a] -> a  
head' [] = error "No head for empty lists!"  
head' (x:_) = x

-- 2.
head' :: [a] -> a  
head' xs = case xs of [] -> error "No head for empty lists!"  
                      (x:_) -> x
```

Case expression syntax:

```
case expression of pattern -> result  
                   pattern -> result  
                   pattern -> result
```

Whereas pattern matching on function parameters can only be done when defining functions, case expressions can be used pretty much anywhere. For instance:

```hs
describeList :: [a] -> String  
describeList xs = "The list is " ++ case xs of [] -> "empty."  
                                               [x] -> "a singleton list."   
                                               xs -> "a longer list."
```

The above can also be defined as:

```hs
describeList :: [a] -> String  
describeList xs = "The list is " ++ what xs  
    where what [] = "empty."  
          what [x] = "a singleton list."  
          what xs = "a longer list."
```
