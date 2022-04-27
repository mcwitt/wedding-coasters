-- Adapted from https://diagrams.github.io/gallery/Hilbert.lhs
{-# LANGUAGE LambdaCase #-}

module Designs.Hilbert where

import Data.List (span)
import Data.Maybe (mapMaybe)
import Diagrams.Prelude

hilbert :: RealFloat n => Int -> Trail V2 n
hilbert 0 = mempty
hilbert n =
  hilbert' (n - 1)
    # reflectY
      <> vrule 1
      <> hilbert (n - 1)
      <> hrule 1
      <> hilbert (n - 1)
      <> vrule (-1)
      <> hilbert' (n - 1)
    # reflectX
  where
    hilbert' m = hilbert m # rotateBy (1 / 4)

hilbert' n =
  (hilbert n `at` p2 (0, 0))
    # moveOriginBy (r2 (2 ^ (n - 1) - 1 / 2, -2 ^ (n - 1)))
    # explodeTrail
    # spans
      ( \lt ->
          let r = 2 ^ (n - 1)
           in norm (loc lt) < r && norm (loc lt .+^ trailOffset (unLoc lt)) < r
      )
    # mapMaybe
      ( \case
          [] -> Nothing
          (x : xs) -> Just $ mconcat (map unLoc (x : xs)) `at` loc x
      )
    # flip zip (cycle [none, veryThin])
    # map (\(lt, w) -> strokeLocTrail lt # lw w)
    # mconcat
  where
    spans :: (a -> Bool) -> [a] -> [[a]]
    spans p [] = []
    spans p xs = let (ys, zs) = span p xs in ys : spans (not . p) zs
