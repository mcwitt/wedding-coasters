{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE TupleSections #-}

module Designs.RandomWalk where

import Control.Monad
import Data.Functor.Base (TreeF (NodeF))
import Data.Functor.Foldable
import Data.List (find)
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Tree
import Diagrams.Prelude
import System.Random (RandomGen, Uniform, mkStdGen, split, uniformR)
import System.Random.Shuffle

newtype Dist g a = Dist {runDist :: g -> (a, g)} deriving (Functor)

instance RandomGen g => Applicative (Dist g) where
  pure x = Dist (x,)
  Dist ff <*> Dist fx = Dist $ \g ->
    let (g1, g2) = split g
        (f, _) = ff g1
        (x, g') = fx g2
     in (f x, g')

instance RandomGen g => Monad (Dist g) where
  Dist fx >>= f = Dist $ \g ->
    let (a, g') = fx g
        Dist fy = f a
     in fy g'

generateM :: Monad m => (a -> m [a]) -> a -> m (Tree a)
generateM f x = do
  xs <- f x
  ts <- traverse (generateM f) xs
  pure (Node x ts)

prune :: Ord a => Tree a -> Tree a
prune = flip (cata alg) Set.empty
  where
    alg (NodeF x fs) vs | Set.notMember x vs = Node x [f (Set.insert x vs) | f <- fs]
    alg (NodeF x _) _ = Node x []

paths :: Tree a -> Int -> [[a]]
paths = cata go
  where
    go (NodeF x _) 1 = [[x]]
    go (NodeF x []) _ = [[x]]
    go (NodeF x fs) n = [x : p | f <- fs, p <- f (n - 1)]

splitGen :: RandomGen g => (g -> a) -> Dist g a
splitGen f = Dist $ \g ->
  let (g', g'') = split g
      x = f g'
   in (x, g'')

selfAvoidingWalk :: RandomGen g => (Int, Int) -> Int -> Dist g [(Int, Int)]
selfAvoidingWalk origin steps = do
  t <- generateM neighborsGen (0, 0)
  let ps = flip paths steps $ prune t
      Just p = find ((== steps) . length) ps
  pure p
  where
    neighborsGen p = let ns = neighbors p in splitGen . shuffle' ns $ length ns
    neighbors (x, y) =
      [ (x + 1, y),
        (x - 1, y),
        (x, y + 1),
        (x, y - 1)
      ]
