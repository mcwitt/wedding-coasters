module Designs.GaussianPrimes where

import Diagrams.Prelude

primes = sieve [2 ..]
  where
    sieve (x : xs) = x : sieve [x' | x' <- xs, x' `mod` x /= 0]

isPrime n = not . any (`divides` n) $ takeWhile (<= isqrt n) primes
  where
    divides k n = n `mod` k == 0
    isqrt = ceiling . sqrt . fromIntegral

isGaussianPrime a b = isPrime (a ^ 2 + b ^ 2) || cond a b || cond b a
  where
    cond x y = x == 0 && isPrime y && y `mod` 4 == 3

gaussianPrimes n =
  position
    [ (p2 (fromIntegral x, fromIntegral y), square 1)
      | x <- [-n .. n],
        y <- [-n .. n],
        x ^ 2 + y ^ 2 < fromIntegral n ^ 2,
        isGaussianPrime x y
    ]
