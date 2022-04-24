import Designs.Hilbert
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

example = hilbert 5 # strokeT # lw medium

main = mainWith (example :: Diagram B)
