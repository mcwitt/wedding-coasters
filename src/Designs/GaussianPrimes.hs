module Designs.GaussianPrimes where

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

isGaussianPrime a b = isPrime (a ^ 2 + b ^ 2) || p a b || p b a
  where
    p x y = x == 0 && isPrime (abs y) && abs y `mod` 4 == 3

gaussianPrimes n =
  position
    [ (p2 (fromIntegral x, fromIntegral y), square 1)
      | x <- [-n .. n],
        y <- [-n .. n],
        x ^ 2 + y ^ 2 < fromIntegral n ^ 2,
        isGaussianPrime x y
    ]
