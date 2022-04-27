import Designs.GaussianPrimes
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

example = gaussianPrimes 40 # lw none # fc green

main = mainWith (example :: Diagram B)
