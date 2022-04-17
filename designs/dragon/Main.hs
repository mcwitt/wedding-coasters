import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude
import Lib (makeCoaster)

dragons = map (trailLike . (`at` origin)) $ iterate go (hrule 1)
  where
    go trail = trail # rotateBy (-1 / 8) <> trail # rotateBy (5 / 8) # reverseTrail

example = dragons !! 10

main = mainWith (makeCoaster example :: Diagram B)
