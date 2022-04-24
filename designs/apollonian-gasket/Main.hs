-- Adapted from https://diagrams.github.io/gallery/Apollonian.lhs

import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude
import Diagrams.TwoD.Apollonian
import Lib (makeCoaster)

example = apollonianGasket 0.01 2 3 4

main = mainWith (makeCoaster example :: Diagram B)
