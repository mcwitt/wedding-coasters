module Main where

import Coaster (arrange, coaster)
import Designs (designs)
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

main = mainWith (arrange 3 $ map (coaster . Just . lw thin) designs :: Diagram B)
