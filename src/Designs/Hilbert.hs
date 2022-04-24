-- Adapted from https://diagrams.github.io/gallery/Hilbert.lhs
module Designs.Hilbert where

import Diagrams.Prelude

hilbert :: RealFloat n => Int -> Trail V2 n
hilbert 0 = mempty
hilbert n =
  hilbert' (n - 1)
    # reflectY
      <> vrule 1
      <> hilbert (n - 1)
      <> hrule 1
      <> hilbert (n - 1)
      <> vrule (-1)
      <> hilbert' (n - 1)
    # reflectX
  where
    hilbert' m = hilbert m # rotateBy (1 / 4)
