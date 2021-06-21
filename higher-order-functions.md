**Table of contents**

- [Higher order functions](#higher-order-functions)
  - [What is?](#what-is)
  - [Curried functions](#curried-functions)

# Higher order functions

## What is?

Haskell functions can take functions as parameters and return functions as return values. A function that does either of those is called a higher order function. Higher order functions aren't just a part of the Haskell experience, they pretty much are the Haskell experience. It turns out that if you want to define computations by defining what stuff is instead of defining steps that change some state and maybe looping them, higher order functions are indispensable. They're a really powerful way of solving problems and thinking about programs.

## Curried functions

Functions in haskell only take one parameter and are curried. Example `max 4 5` first creates a function that takes a parameter and returns either 4 or that parameter, depending on which is bigger. Then, 5 is applied to that function and that function produces our desired result.

`max :: (Ord a) => a -> a -> a`

The above can also be written as

`max :: (Ord a) => a -> (a -> a)` that could be read as: max takes an a and returns (that's the ->) a function that takes an a and returns an a. That's why the return type and the parameters of functions are all simply separated with arrows.
