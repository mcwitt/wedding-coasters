{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE TupleSections #-}

import Data.Functor.Base (TreeF (NodeF))
import Data.Functor.Foldable
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Tree
import Diagrams.Backend.SVG.CmdLine
import Diagrams.Prelude
import Lib (makeCoaster)
import System.Random
import System.Random.Shuffle (shuffle')

newtype Dist g a = Dist {runDist :: g -> (a, g)} deriving (Functor)

instance RandomGen g => Applicative (Dist g) where
  pure x = Dist (x,)
  Dist ff <*> Dist fx = Dist $ \g ->
    let (g1, g2) = split g
        (f, _) = ff g1
        (x, g') = fx g2
     in (f x, g')

splitDist :: RandomGen g => (g -> a) -> Dist g a
splitDist f = Dist $ \g -> let (g', g'') = split g in (f g', g'')

neighbors :: V2 Int -> [V2 Int]
neighbors (V2 x y) =
  [ V2 (x + 1) y,
    V2 (x - 1) y,
    V2 x (y + 1),
    V2 x (y - 1)
  ]

generate :: (a -> [a]) -> a -> Tree a
generate f x = Node x (generate f <$> f x)

generateA :: Applicative f => f (a -> [a]) -> f a -> f (Tree a)
generateA f x = let a = f <*> x in _

-- generateA f x = do
--   xs <- f x
--   ts <- traverse (generateA f) xs
--   pure (Node x ts)

shuffledNeighbors :: RandomGen g => V2 Int -> Dist g [V2 Int]
shuffledNeighbors p =
  let ns = neighbors p
   in splitDist $ shuffle' ns (length ns)

prune :: Ord a => Tree a -> Tree a
prune = flip (cata alg) Set.empty
  where
    alg :: Ord a => TreeF a (Set a -> Tree a) -> Set a -> Tree a
    alg (NodeF x fs) vs | Set.notMember x vs = Node x [f (Set.insert x vs) | f <- fs]
    alg (NodeF x _) _ = Node x []

paths :: Tree a -> Int -> [[a]]
paths (Node x _) 0 = [[x]]
paths (Node x []) n = [[x]]
paths (Node x ts) n = [x : p | t <- ts, let ps = paths t (n - 1), p <- ps]

(t, _) = flip runDist (mkStdGen 123) $ generateA shuffledNeighbors (V2 0 0)

example = hrule 1

main = mainWith (makeCoaster example :: Diagram B)
