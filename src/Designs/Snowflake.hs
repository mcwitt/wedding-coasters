module Designs.Snowflake where

import Diagrams.Prelude

koch 0 l = hrule 1
koch n l =
  let t' = koch (n - 1) (l / 3)
   in t' <> rotateBy (1 / 6) t' <> rotateBy (-1 / 6) t' <> t'

snowflake n l =
  let t = koch n l
   in t <> rotateBy (-1 / 3) t <> rotateBy (1 / 3) t
