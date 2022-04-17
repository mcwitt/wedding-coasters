module Lib where

import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

makeCoaster :: Diagram B -> Diagram B
makeCoaster diagram =
  let outline = circle 1
   in strokeP outline
        `atop` diagram
        # centerXY
        # sized (dims2D 2 2)
        # clipBy outline
        # lc green
        # fc green
