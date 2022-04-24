module Designs.Dragon where

import Diagrams.Prelude

dragons = map (trailLike . (`at` origin)) $ iterate go (hrule 1)
  where
    go trail = trail # rotateBy (-1 / 8) <> trail # rotateBy (5 / 8) # reverseTrail
