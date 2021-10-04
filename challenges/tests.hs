module MathSpec where

import Test.Hspec
import MathTest

main :: IO ()
main = hspec $ do
    describe "absolute" $ do
        it "returns the original number given input" $
            absolute 1 `shouldBe` 1