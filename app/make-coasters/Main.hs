module Main where

import Coaster (arrange, coaster)
import Designs (designs)
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

main = mainWith (arrange 6 $ map (coaster . Just) designs :: Diagram B)
