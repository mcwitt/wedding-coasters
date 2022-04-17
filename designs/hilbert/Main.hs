-- Adapted from https://diagrams.github.io/gallery/Hilbert.lhs

import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

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

example = frame 1 . lw medium . strokeT $ hilbert 5

main = mainWith (example :: Diagram B)
