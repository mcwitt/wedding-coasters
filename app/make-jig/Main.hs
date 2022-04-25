module Main where

import Coaster (arrange, coaster)
import Designs (designs)
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

main =
  let outline = coaster Nothing
   in mainWith (arrange . replicate 6 $ outline :: Diagram B)
