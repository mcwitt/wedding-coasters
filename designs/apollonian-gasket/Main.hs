-- Adapted from https://diagrams.github.io/gallery/Apollonian.lhs

import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude
import Diagrams.TwoD.Apollonian

example = apollonianGasket 0.01 2 3 3 # centerXY # pad 1.1

main = mainWith (example :: Diagram B)
