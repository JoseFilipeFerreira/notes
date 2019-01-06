module Ficha8 where

data ExpInt = Const Int
            | Simetrico ExpInt
            | Mais ExpInt ExpInt
            | Menos ExpInt ExpInt
            | Mult ExpInt ExpInt
            deriving Show

calcula:: ExpInt -> Int
calcula (Const n) = n
calcula (Simetrico n) = (-1) * calcula n
calcula (Mais l r) =  (calcula l) + (calcula r)
calcula (Menos l r) = (calcula l) - (calcula r)
calcula (Mult l r) = (calcula l) * (calcula r)

infixa:: ExpInt -> String
infixa (Const n) = show n
infixa (Simetrico n) = "-(" ++ infixa n ++ ")"
infixa (Mais l r)    = "(" ++ (infixa l) ++ "+" ++ (infixa r) ++ ")"
infixa (Menos l r)   = "(" ++ (infixa l) ++ "-" ++ (infixa r) ++ ")"
infixa (Mult l r)    = "(" ++ (infixa l) ++ "*" ++ (infixa r) ++ ")"

posfixa :: ExpInt -> String
posfixa (Const n) = show n
posfixa (Simetrico n) = (posfixa n) ++ "-"
posfixa (Mais l r)    = (posfixa l) ++ (posfixa r) ++ "+"
posfixa (Menos l r)   = (posfixa l) ++ (posfixa r) ++ "-" 
posfixa (Mult l r)    = (posfixa l) ++ (posfixa r) ++ "*"

data RTree a = R a [RTree a] deriving Show

soma :: Num a => RTree a -> a
soma (R v []) = v
soma (R v l) = v + sum (map (soma) l)

altura :: RTree a -> Int
altura (R _ []) = 1
altura (R _ l)  = 1 + maximum (map altura l)

prune :: Int -> RTree a -> RTree a
prune 0 (R v l) = (R v [])
prune n (R v l) = (R v (map (prune (n-1)) l) )

mirror :: RTree a -> RTree a
mirror (R v []) = (R v [])
mirror (R v l) = (R v (reverse (map (mirror) l)) )

postorder :: RTree a -> [a]
postorder (R v []) = [v]
postorder (R v l)  = reverse (foldr (++) [] (map (reverse) (map (postorder) l))) ++ [v]

data LTree a = Tip a | Fork (LTree a) (LTree a)

ltSum :: Num a => LTree a -> a
ltSum (Tip v) = v
ltSum (Fork l r) = (ltSum l) + (ltSum r)

listaLT :: LTree a -> [a]
listaLT (Tip a) = [a]
listaLT (Fork l r) = (listaLT l) ++ (listaLT r)

ltHeight :: LTree a -> Int
ltHeight (Tip _) = 1
ltHeight (Fork l r) = 1 + maximum [ltHeight l, ltHeight r]