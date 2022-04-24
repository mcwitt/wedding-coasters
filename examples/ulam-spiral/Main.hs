import Designs.UlamSpiral
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

example = ulamSpiral 40 # lw none # fc green

main = mainWith (example :: Diagram B)
