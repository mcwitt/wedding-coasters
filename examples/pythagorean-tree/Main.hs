import Designs.PythagoreanTree
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

example =
  tree (40 @@ deg) 10
    # (`at` origin)
    # trailVertices
    # cubicSpline True
    # lw none

main = mainWith (example :: Diagram B)
