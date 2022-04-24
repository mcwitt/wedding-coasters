import Designs.Dragon (dragons)
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

example = dragons !! 10

main = mainWith (example :: Diagram B)
