-- Adapted from https://diagrams.github.io/gallery/Hilbert.lhs
{-# LANGUAGE LambdaCase #-}

module Designs.Hilbert where

import Control.Applicative (ZipList (ZipList, getZipList))
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

-- | Hilbert curve pruned to fit in a circle
hilbert' n =
  (hilbert n `at` p2 (0, 0))
    # moveOriginBy (r2 (2 ^ (n - 1) - 1 / 2, -2 ^ (n - 1)))
    # explodeTrail -- split trail into segments
    # spans -- divide into spans alternating between inside and outside the circle
      ( \lt ->
          let r = 2 ^ (n - 1)
           in norm (loc lt) < r && norm (loc lt .+^ trailOffset (unLoc lt)) < r
      )
    # mapMaybe
      ( \case
          [] -> Nothing
          (x : xs) -> Just $ mconcat (map unLoc (x : xs)) `at` loc x
      )
    # map strokeLocTrail
    # (\lts -> ZipList (cycle [lw none, id]) <*> ZipList lts) -- set line width to 'none' outside the circle
    # getZipList
    # mconcat
  where
    spans :: (a -> Bool) -> [a] -> [[a]]
    spans p [] = []
    spans p xs = let (ys, zs) = span p xs in ys : spans (not . p) zs
