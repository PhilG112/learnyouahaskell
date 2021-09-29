module Main where
import Control.Applicative ((<$>), (<*>))
import Calc (calculate)


main :: IO ()
main = print $ calculate "2 + 6 * 77"