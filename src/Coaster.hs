module Coaster (Coaster, coaster, arrange) where

import Data.Typeable
import Diagrams.Prelude
import Diagrams.TwoD.Layout.Grid

newtype Coaster b n = Coaster {unCoaster :: QDiagram b V2 n Any}

type instance N (Coaster b n) = n

type instance V (Coaster b n) = V2

instance (Floating n, Ord n) => Transformable (Coaster b n) where
  transform t (Coaster d) = Coaster (transform t d)

coaster :: (Renderable (Path V2 n) b, TypeableFloat n) => Maybe (QDiagram b V2 n Any) -> Coaster b n
coaster dia = Coaster $ case dia of
  Just d -> d # sized (dims2D 2 2) # centerXY # clipBy (circle 0.98)
  Nothing -> circle 1 # strokeP

arrange :: (TypeableFloat n) => [Coaster b n] -> QDiagram b V2 n Any
arrange = gridCat' 4 . fmap unCoaster
