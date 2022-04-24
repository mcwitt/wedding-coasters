import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude
import Lib (makeCoaster)

sunflower :: [P2 Double]
sunflower = [p2 $ fromPolar (sqrt m) (2.4 * m) | m <- [1 ..]]
  where
    fromPolar r θ = (r * cos θ, r * sin θ)

example = position [(p, dot) | p <- take 2000 sunflower]
  where
    dot = circle 0.6 # lw none

main = mainWith (makeCoaster example :: Diagram B)
