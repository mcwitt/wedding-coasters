import Designs.RandomWalk (runSelfAvoidingWalk)
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

example = runSelfAvoidingWalk 2 40 1800 (0, 0) 8

main = mainWith (example :: Diagram B)
