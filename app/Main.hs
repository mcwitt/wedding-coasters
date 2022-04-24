module Main where

import Coaster (arrange, coaster)
import Designs.Dragon (dragons)
import Designs.Hilbert (hilbert)
import Designs.PythagoreanTree (tree)
import Designs.Snowflake (snowflake)
import Designs.Sunflower (sunflower)
import Designs.UlamSpiral (ulamSpiral)
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

main =
  mainWith
    ( arrange $
        map
          (coaster . Just)
          [ dragons !! 10,
            hilbert 5 # strokeT,
            (tree (40 @@ deg) 10 `at` origin) # trailVertices # cubicSpline True,
            ulamSpiral 40 # lw none # fc black,
            snowflake 4 1 # strokeT,
            sunflower 0.6 2000 # lw none # fc black
          ] ::
        Diagram B
    )
