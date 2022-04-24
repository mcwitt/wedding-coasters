import Designs.Sunflower
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

example = sunflower 0.6 2000

main = mainWith (example :: Diagram B)
