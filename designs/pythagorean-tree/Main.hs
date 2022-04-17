import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude
import Lib (makeCoaster)

tree θ = go 1
  where
    go w 1 = fromOffsets $ map r2 [(0, w), (w, 0), (0, - w)]
    go w n =
      fromOffsets [r2 (0, w)]
        <> go (w * cosA θ) (n - 1) # rotate θ
        <> go (w * sinA θ) (n - 1) # rotate (θ <> (-1 / 4 @@ turn))
        <> fromOffsets [r2 (0, - w)]

example =
  (tree (40 @@ deg) 10 `at` origin)
    # trailVertices
    # cubicSpline True
    # lw none
    # frame 1

main = mainWith (makeCoaster example :: Diagram B)
