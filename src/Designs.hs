module Designs where

import Designs.Dragon (dragons)
import Designs.GaussianPrimes (gaussianPrimes)
import Designs.Hilbert (hilbert')
import Designs.PythagoreanTree (tree)
import Designs.RandomWalk (runSelfAvoidingWalk)
import Designs.Snowflake (antisnowflake, snowflake)
import Designs.Sunflower (sunflower)
import Designs.UlamSpiral (ulamSpiral)
import Diagrams.Prelude
import Diagrams.TwoD.Apollonian

designs :: Renderable (Path V2 Double) b => [QDiagram b V2 Double Any]
designs =
  [ dragons !! 10 # centerXY # pad 1.2,
    hilbert' 5 # pad 1.1,
    (tree (40 @@ deg) 10 `at` origin)
      # trailVertices
      # cubicSpline True
      # centerXY
      # pad 1.2,
    antisnowflake 4 # pad 1.3,
    runSelfAvoidingWalk 2 40 1800 (0, 0) 8 # centerXY # pad 1.2,
    apollonianGasket 0.01 2 3 4 # centerXY # pad 1.1
  ]
    <> take
      6
      ( cycle
          [ gaussianPrimes 40 # lw none # fc black # pad 1.1,
            sunflower 0.6 1000 # lw none # fc black # pad 1.1
          ]
      )
