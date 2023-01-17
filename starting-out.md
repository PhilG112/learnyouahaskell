*Table of contents*
- [Starting out](#starting-out)
  - [Ready, set, go!testtest2](#ready-set-gotesttest2)
  - [Baby's first functions](#babys-first-functions)
    - [Anatomy of a function](#anatomy-of-a-function)
    - [Call functions from other functions](#call-functions-from-other-functions)
    - [Function with logic](#function-with-logic)
  - [An intro to lists](#an-intro-to-lists)
    - [Concatination](#concatination)
    - [Cons operator :](#cons-operator-)
    - [Remove element by index !!](#remove-element-by-index-)
    - [List comprehension](#list-comprehension)
    - [Tuples](#tuples)

# Starting out

## Ready, set, go!testtest2

**succ gets the successor**

`succ 8` returns 9

**min gets the minimum of a series**

`min 9 10` returns 9

`min 3.4 3.2` returns 3.2

**max gets the maximum of a series**

`max 100 101` returns 101

**combination of the above**
`succ 9 + max 5 4 + 1` returns 16
`(succ 9) + (max 5 4) + 1` returns 16

*Remember that `succ 9 * 10` gets the succ of 9 then multiple by 10. Parenthesis are required*

## Baby's first functions

### Anatomy of a function

**name -> parameters -> body**

`doubleMe x = x + x`

`doubleMe 8` returns 16

`doubleUs x y = x*2 + y*2`

`doubleUs 4 9` returns 26

### Call functions from other functions

`doubleUs x y = doubleMe x + doubleMe y`

### Function with logic

```hs
doubleSmallNumber x = if x > 100
                        then x
                        else x*2
```

> Unlike most languages the else block in haskell is mandatory

**Do the same as above but wrap the expression in parentheses
**

```hs
doubleSmallNumber' x = (if x > 100 then x else x*2) + 1
```

> The ' apostrophe in the function name denotes a strict version of a function (one that isn't lazy) or a slightly modified version of a function or a variable

## An intro to lists

`myFirstList = [1,2,3,4,5]`

### Concatination

`[1,2,3,4] ++ [9,10,11,12]` returns [1,2,3,4,9,10,11,12]

`"hello" ++ " " ++ "world"` returns "hello world"

> Haskell has to walk through the whole list on the left side of ++. That's not a problem when dealing with lists that aren't too big. But putting something at the end of a list that's fifty million entries long is going to take a while.

### Cons operator :

Put something at the start of a list.

`'A': " small cat"` returns "A small cat"

`[1,2,3]` is actually just syntactic sugar for `1:2:3:[]`. `[]` is an empty list. If we prepend 3 to it, it becomes `[3]`. If we prepend 2 to that, it becomes `[2,3], and so on.

> [], [[]] and [[],[],[]] are all different things. The first one is an empty list, the seconds one is a list that contains one empty list, the third one is a list that contains three empty lists.

### Remove element by index !!

`"test string" !! 5` returns s

> Can error when index out of bounds

**Lists within lists**

`[[1,2,3,4],[5,3,3,3],[1,2,2,3,4],[1,2,3]]`

> The lists within a list can be of different lengths but they can't be of different types

**List comparison**

Lists can be compared if the stuff they contain can be compared. When using <, <=, > and >= to compare lists, they are compared in lexicographical order. First the heads are compared. If they are equal then the second elements are compared, etc.

```hs
[3,2,1] > [2,1,0]  
True  
[3,2,1] > [2,10,100]  
True  
[3,4,2] > [3,4]  
True  
[3,4,2] > [2,4]  
True  
[3,4,2] == [3,4,2]  
True
```

### List comprehension

Pipe a certain input to an output operation with an optional predicate.

[output | function input]

`[x*2 | x <- [1..10]]`

returns [12,14,16,18,20]

Add a predicate. We want only the elements which, doubled, are greater than or equal to 12.

[output | function input, predicate]

`[x*2 | x <- [1..10], x*2 >= 12]`

returns [12,14,16,18,20]

How about if we wanted all numbers from 50 to 100 whose remainder when divided with the number 7 is 3?

[output | function input, predicate]

`[ x | x <- [50..100], x`mod`7 == 3]`

returns [52,59,66,73,80,87,94]

> This is often called filtering

function name parameter = [output | function input, predicate]

`boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]`

Multiple predicates

[output | function input, predicates...]

`[ x | x <- [10..20], x /= 13, x /= 15, x /= 19] `

The above returns all numbers from 10 to 20 that are not 13, 15 and 19: `[10,11,12,14,16,17,18,20]`

Multiple lists in comprehension

[output | function inputs, predicates]

`[ x*y | x <- [2,5,10], y <- [8,10,11]]`

Gives all combinations between both lists

Returns: `[16,20,22,40,50,55,80,100,110]`

Multiple lists with predicates

[output | list1, list2, predicates]

`[ x*y | x <- [2,5,10], y <- [8,10,11], x*y > 50]`

returns `[55,80,100,110]`

```hs
nouns = ["hobo","frog","pope"] 
adjectives = ["lazy","grouchy","scheming"]
-- [output | list1, list2]
[adjective ++ " " ++ noun | adjective <- adjectives, noun <- nouns] -- concat all possible combinations between two lists

["lazy hobo","lazy frog","lazy pope","grouchy hobo","grouchy frog",  
"grouchy pope","scheming hobo","scheming frog","scheming pope"]
```

Alternate implementation of length

name param = operation [output | input]]

`length' xs = sum [1 | _ <- xs]`

```hs
removeNonUppercase st = -- name + parameter
                        [ c | -- output
                        c <- st, -- pipe the input into c
                        c `elem` ['A'..'Z']] -- predicate: only output characters in ['A'..'Z']
```

```hs
-- Remote all odd numbers without flattening list
let xxs = [[1,3,5,2,3,1,2,4,5],[1,2,3,4,5,6,7,8,9],[1,2,4,2,1,6,3,1,3,2,3,6]]  

-- Nested comprehension
-- The nested comprehension applies to all lists within xxs
-- Each nested list is bound to xs
[[ x | x <- xs, even x ] | xs <- xxs]  

-- output 
[[2,2,4],[2,4,6,8],[2,4,2,6,2,6]]
```

### Tuples

- Tuples within a list must be the same size.
- Tuples must be the same data type
- Tuples/triples can contain multiple types
  
`fst` function returns first component: fst (8,11) -> 8
`snd` function returns second component: snd (8, 11) -> 11

> Note: these functions operate only on pairs. They won't work on triples, 4-tuples, 5-tuples, etc. We'll go over extracting data from tuples in different ways a bit later.

`zip` function will zip two lists together into one list of pairs. The length is determined by the length of the shorter list.

`zip [1,2,3] [1,2,3]` returns [(1,1),(2,2),(3,3)]

> You can zip lists of different types

Outputs a list of pair combinations of all 3 lists in the comprehension

[name = [outputVariables | list1, list2, list3 ]]

`let trianlges = [ (a,b,c) | c <- [1..10], b <- [1..10], a <- [1..10] ]`



`let rightTriangles = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2]`

Transformation of the above where the perimeter is 24

`let rightTriangles' = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2, a+b+c == 24]`