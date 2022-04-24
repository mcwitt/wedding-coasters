import Designs.RandomWalk
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

example =
  let (xs, _) = flip runDist (mkStdGen 137) $ selfAvoidingWalk (0, 0) 1500
   in fromVertices [p2 (fromIntegral x, fromIntegral y) | (x, y) <- xs]
        # strokeP

main = mainWith (makeCoaster example :: Diagram B)
