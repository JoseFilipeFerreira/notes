module Exercicios where

import Data.List
-- exercicio 1 
myInsert:: Ord a => a -> [a] -> [a]
myInsert x [] = [x]
myInsert x (h:t) | x <= h = (x : (h:t))
               | x >  h = (h:myInsert x t)

-- exercicio 2
myCatMaybes ::[Maybe a] -> [a]
myCatMaybes [] = []
myCatMaybes (Just x : t) = x : myCatMaybes t
myCatMaybes (Nothing: t) =     myCatMaybes t

-- exercicio 3
data Exp a = Const a | Var String | Mais (Exp a) (Exp a) | Mult (Exp a) (Exp a)

{-
instance Show Exp a
show (Const x) = show x
show (Var   x) = x
show (Mais l r) = "(" ++ (show l) ++ "+" ++ (show r) ++ ")"
show (Mult l r) = "(" ++ (show l) ++ "*" ++ (show r) ++ ")"
-}
-- exercicio 4
mySortOn:: Ord b => (a -> b) -> [a] -> [a]
mySortOn f [] = []
mySortOn f (h:t) = myInsertOn f h (mySortOn f t)

myInsertOn:: Ord b => (a -> b) -> a -> [a] -> [a]
myInsertOn f l [] = [l]
myInsertOn f l (h:t) |f l >  f h = h : (myInsertOn f l t)
                   |f l <= f h = (l : (h : t))

-- exrcicio 5a
amplitude:: [Int] -> Int
amplitude [] = 0
amplitude (h:t) = maxL - minL
            where
                (minL, maxL) = amplitudeaux t (h,h)

amplitudeaux:: [Int] -> (Int,Int) -> (Int,Int)
amplitudeaux [] x = x
amplitudeaux (h:t) (x,y)| h < x     = amplitudeaux t (h,y)
                        | h > y     = amplitudeaux t (x,h)
                        | otherwise = amplitudeaux t (x,y)

-- exercicio 5b
parte:: [Int] -> ([Int],[Int])
parte l = parteaux (sort l)

parteaux:: [Int] -> ([Int], [Int])
parteaux l = minimize (generate l (length l))

generate:: [Int] -> Int -> [([Int], [Int])]
generate l 0 = [([], l)]
generate l n = (take n l, drop ((length l) - n) l) : (generate l (n-1))

minimize:: [([Int], [Int])] -> ([Int], [Int])
minimize [x] = x
minimize (x : (y : t))|ampCalc x >  ampCalc y = minimize (y:t)
                      |ampCalc x <= ampCalc y = minimize (x:t)

ampCalc::([Int], [Int]) -> Int
ampCalc (l,r) = amplitude l + amplitude r