module TonysBlog where

-- https://blog.tmorris.net/posts/20-intermediate-haskell-exercises/

{-
Fill in the blanks (which are marked error "todo") with a nontrivial implementation that typechecks.
I recommend that you use the run button after implementing each one to make sure that it still typechecks.
Let the types guide you!
If you have trouble implementing a typeclass method, then try writing out the specialized type that it should have.
For example, furry imlpemented for [] should have the type (a -> b) -> [a] -> [b].
-}

class Fluffy f where
  furry :: (a -> b) -> f a -> f b

-- fmap is used to apply a function of type (a -> b) to a value of type f a, where f is a functor,to produce a value of type f b
instance Fluffy [] where
    furry = fmap


