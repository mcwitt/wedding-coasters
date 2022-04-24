module Designs.PythagoreanTree where

import Diagrams.Prelude

tree θ = go 1
  where
    go w 1 = fromOffsets $ map r2 [(0, w), (w, 0), (0, -w)]
    go w n =
      fromOffsets [r2 (0, w)]
        <> go (w * cosA θ) (n - 1) # rotate θ
        <> go (w * sinA θ) (n - 1) # rotate (θ <> (-1 / 4 @@ turn))
        <> fromOffsets [r2 (0, -w)]
