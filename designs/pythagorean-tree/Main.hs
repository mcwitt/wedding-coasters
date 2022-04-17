import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude

tree θ = go 1
  where
    go w 1 = fromOffsets $ map r2 [(0, w), (w, 0), (0, - w)]
    go w n =
      fromOffsets [r2 (0, w)]
        <> go (w * cosA θ) (n - 1) # rotate θ
        <> go (w * sinA θ) (n - 1) # rotate (θ <> (3 / 4 @@ turn))
        <> fromOffsets [r2 (0, - w)]

example = frame 1 . lw veryThin . strokeT $ tree (40 @@ deg) 10

main = mainWith (example :: Diagram B)
