module Designs.Sunflower where

import Diagrams.Prelude

sunflowerPoints :: (Enum n, Floating n) => [P2 n]
sunflowerPoints = [p2 $ fromPolar (sqrt m) (2.4 * m) | m <- [1 ..]]
  where
    fromPolar r θ = (r * cos θ, r * sin θ)

sunflower r n = position [(p, circle r) | p <- take n sunflowerPoints]
