# Functional Programming in Haskell

Going through https://www.youtube.com/playlist?list=PLF1Z-APd9zK7usPMx3LGMZEHrECUGodd3

## Notes

*Q: What is a type?*

- A type is a name for a collection of related values. E.g bool contains two values, true or false.

*Q: What are curried functions?*

- Functions with multiple arguments are also possible by returning functions as results:

```hs
add :: Int -> (Int -> Int) -- Brackets aren't strictly needed here, as the arrow associates to the right.
add x y = x + y
```
