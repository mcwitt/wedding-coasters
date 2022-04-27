import Designs.Hilbert
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

main = mainWith (hilbert' 5 :: Diagram B)
