module Main where

import Prelude

import App.Button as Button
import Control.Monad.Error.Class (try)
import Effect (Effect)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Node.Encoding (Encoding(..))
import Node.FS.Async (readTextFile)

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  runUI Button.component unit body
