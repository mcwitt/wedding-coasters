-- Adapted from https://diagrams.github.io/gallery/Hilbert.lhs

import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude
import Lib (makeCoaster)

hilbert 0 = mempty
hilbert n =
  hilbert' (n -1) # reflectY <> vrule 1
    <> hilbert (n -1)
    <> hrule 1
    <> hilbert (n -1)
    <> vrule (-1)
    <> hilbert' (n -1) # reflectX
  where
    hilbert' m = hilbert m # rotateBy (1 / 4)

example = hilbert 5 # strokeT # centerXY # lw medium . frame 1

main = mainWith (makeCoaster example :: Diagram B)
