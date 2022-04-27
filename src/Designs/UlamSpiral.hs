module Designs.UlamSpiral where

import Diagrams.Prelude

primes = sieve [2 ..]
  where
    sieve (x : xs) = x : sieve [x' | x' <- xs, x' `mod` x /= 0]

isPrime 0 = False
isPrime 1 = False
isPrime 2 = True
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

ulamSpiral n =
  position
    [ (p2 (x, y), square 1)
      | (i, V2 sx sy) <- zip [1 ..] (spiral n),
        isPrime i,
        let (x, y) = (getSum sx, getSum sy),
        x ^ 2 + y ^ 2 < fromIntegral n ^ 2
    ]
