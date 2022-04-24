import Diagrams.Backend.SVG.CmdLine
import Diagrams.Path (pathPoints)
import Diagrams.Prelude
import Lib (makeCoaster)

primes = sieve [2 ..]
  where
    sieve (x : xs) = x : sieve [x' | x' <- xs, x' `mod` x /= 0]

isPrime n = not . any (`divides` n) $ takeWhile (<= isqrt n) primes
  where
    divides k n = n `mod` k == 0
    isqrt = ceiling . sqrt . fromIntegral

spiral = scanl1 (<>) . offsets
  where
    offsets 0 = [e]
    offsets i =
      offsets (i - 1)
        <> replicate i n
        <> replicate (2 * i) w
        <> replicate (2 * i) s
        <> replicate (2 * i + 1) e
        <> replicate i n

    n = r2 (0, 1)
    e = r2 (1, 0)
    s = r2 (0, -1)
    w = r2 (-1, 0)

example =
  position
    [ (p2 (getSum x, getSum y), square 1 # lw none)
      | (i, V2 x y) <- zip [1 ..] (spiral 40),
        isPrime i
    ]
  where
    ps = take 10000 primes
    dot = circle 0.2 # fc black

main = mainWith (makeCoaster example :: Diagram B)
