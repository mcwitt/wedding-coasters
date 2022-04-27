module Coaster (Coaster, coaster, arrange) where

import Diagrams.Prelude
import Diagrams.TwoD.Layout.Grid (gridCat')

newtype Coaster b n = Coaster {unCoaster :: QDiagram b V2 n Any}

coaster :: (Renderable (Path V2 n) b, TypeableFloat n) => Maybe (QDiagram b V2 n Any) -> Coaster b n
coaster d =
  let d' = case d of
        Just d -> circle 1 # strokeP `atop` d # sized (dims2D 2 2) # lw veryThin
        Nothing -> circle 1 # strokeP
   in Coaster (d' # pad 1.1)

arrange :: TypeableFloat n => [Coaster b n] -> QDiagram b V2 n Any
arrange = gridCat' 6 . fmap unCoaster
