
-- (c) MP-I (1998/9-2006/7) and CP (2005/6-2019/20)

module LTree where

import Cp
import Data.Monoid
import Control.Applicative
import List

-- (1) Datatype definition -----------------------------------------------------

data LTree a = Leaf a | Fork (LTree a, LTree a) deriving (Show, Eq)

inLTree :: Either a (LTree a, LTree a) -> LTree a
inLTree = either Leaf Fork

outLTree :: LTree a -> Either a (LTree a,LTree a)
outLTree (Leaf a)       = i1 a
outLTree (Fork (t1,t2)) = i2 (t1,t2)

baseLTree g f = g -|- f >< f

-- (2) Ana + cata + hylo -------------------------------------------------------

recLTree f = baseLTree id f          -- that is:  id -|- (f >< f)

cataLTree g = g . (recLTree (cataLTree g)) . outLTree

anaLTree f = inLTree . (recLTree (anaLTree f) ) . f

hyloLTree f g = cataLTree f . anaLTree g

-- (3) Map ---------------------------------------------------------------------

instance Functor LTree
         where fmap f = cataLTree ( inLTree . baseLTree f id )

-- (4) Examples ----------------------------------------------------------------

-- (4.0) Inversion (mirror) ----------------------------------------------------

mirrorLTree = cataLTree (inLTree . (id -|- swap))

-- (4.1) Count and depth -------------------------------------------------------

countLTree = cataLTree (either one add)

depth = cataLTree (either one (succ.umax))

-- (4.2) Serialization ---------------------------------------------------------

tips = cataLTree (either singl conc)

-- (4.3) Double factorial ------------------------------------------------------

dfac 0 = 1
dfac n = hyloLTree (either id mul) dfacd (1,n)

dfacd(n,m) | n==m      = i1 n
           | otherwise = i2 ((n,k),(k+1,m))
                            where k = div (n+m) 2

-- (4.4) Double square function ------------------------------------------------

dsq 0 = 0
dsq n = (cataLTree (either id add) . fmap (\n->2*n-1) . (anaLTree dfacd)) (1,n)

{--
dsq 0 = 0
dsq n = (hyloLTree (either id add) (fdfacd nthodd)) (1,n)
        where   nthodd n = 2*n - 1 
                fdfacd f (n,m) | n==m  = i1   (f n)
                               | otherwise = i2   ((n,k),(k+1,m))
                                        where k = div (n+m) 2
--}

-- (4.5) Fibonacci -------------------------------------------------------------

fib =  hyloLTree (either one add) fibd

-- where

fibd n | n < 2     = i1   ()
       | otherwise = i2   (n-1,n-2)

-- (4.6) Merge sort ------------------------------------------------------------

mSort :: Ord a => [a] -> [a]
mSort [] = []
mSort l = hyloLTree (either singl merge) lsplit l

--where

-- singl   x = [x]

merge (l,[])                  = l
merge ([],r)                  = r
merge (x:xs,y:ys) | x < y     = x : merge(xs,y:ys) 
                  | otherwise = y : merge(x:xs,ys)

lsplit [x] = i1 x
lsplit l   = i2 (sep l) where
     sep []    = ([],[])
     sep (h:t) = let (l,r) = sep t in (h:r,l)  -- a List cata

{-- pointwise version:

mSort :: Ord a => [a] -> [a]
mSort [] = []
mSort [x] = [x]
mSort l = let (l1,l2) = sep l
          in merge(mSort l1, mSort l2)
--}

-- (4.7) Double map (unordered lists) ------------------------------------------

dmap :: (b -> a) -> [b] -> [a]
dmap f [] = []
dmap f x = (hyloLTree (either (singl.f) conc) lsplit) x

-- (4.8) Double map (keeps the order) ------------------------------------------

dmap1 :: (b -> a) -> [b] -> [a]
dmap1 f [] = []
dmap1 f x = (hyloLTree (either (singl.f) conc) divide) x
     where divide [x] = i1 x
           divide l   = i2 (split (take m) (drop m) l) where m = div (length l) 2

-- (4.8) Combinations ----------------------------------------------------------

comb = hyloLTree (either id add) divide
   where divide(n,k) = if k `elem` [0,n] then i1 1 else i2((n-1,k),(n-1,k-1))

{-- pointwise: comb (n,k) = if k `elem` [0,n] then 1 else comb(n-1,k)+comb(n-1,k-1) --}

-- (5) Monad -------------------------------------------------------------------

instance Monad LTree where
     return  = Leaf
     t >>= g = (mu . fmap g) t

instance Strong LTree

mu  :: LTree (LTree a) -> LTree a
mu  =  cataLTree (either id Fork)

{-- fmap :: (Monad m) => (t -> a) -> m t -> m a
    fmap f t = do { a <- t ; return (f a) }
--}

-- (6) Going polytipic -------------------------------------------------------

-- natural transformation from base functor to monoid
tnat :: Monoid c => (a -> c) -> Either a (c, c) -> c
tnat f = either f (uncurry mappend)

-- monoid reduction 

monLTree f = cataLTree (tnat f)

-- alternative to (4.2) serialization ----------------------------------------

tips' = monLTree singl

-- alternative to (4.1) counting ---------------------------------------------

countLTree' = monLTree (const (Sum 1))

-- distributive law ----------------------------------------------------------

dlLTree :: Strong f => LTree (f a) -> f (LTree a)
dlLTree = cataLTree (either (fmap Leaf) (fmap Fork .dstr))

-- (7) Zipper ----------------------------------------------------------------

data Deriv a = Dr Bool (LTree a)

type Zipper a = [ Deriv a ]

plug :: Zipper a -> LTree a -> LTree a
plug [] t = t
plug ((Dr False l):z) t = Fork (plug z t,l) 
plug ((Dr True  r):z) t = Fork (r,plug z t)

-- (8) Advanced --------------------------------------------------------------

instance Applicative LTree where
    pure = return
    (<*>) = aap

-- (9) Spine representation --------------------------------------------------

roll = inLTree.(id -|- roll>< id).beta.(id><outList')

spinecata g = g . (id -|- (spinecata g)>< id).spineOut

spineOut = beta.(id><outList')

outList' [] = i1()
outList' x = i2(last x, blast x)

blast = reverse . tail . reverse

inList' = either nil snoc

snoc(a,x)= x++[a]

unroll = (id><inList').alpha.(id -|- unroll>< id).outLTree

alpha :: Either a ((a, t), t1) -> (a, Either () (t1, t))
alpha(Left a) = (a,Left())
alpha(Right ((a,ts),t)) = (a,Right(t,ts))

beta :: (a, Either () (t1, t)) -> Either a ((a, t), t1)
beta(a,Left()) = Left a
beta(a,Right(t,ts)) = Right ((a,ts),t)

height = cataLTree (either id (uncurry ht)) where ht a b = 1 + (max a b)

---------------------------- end of library ----------------------------------
