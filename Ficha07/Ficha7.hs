module Ficha7 where

data BTree a = Empty | Node a (BTree a) (BTree a) deriving Show

altura:: BTree a -> Int
altura Empty = 0
altura (Node x l r) = 1 + max (altura l) (altura r)

contaNodos :: BTree a -> Int
contaNodos Empty = 0
contaNodos (Node x l r) = 1 + (contaNodos l) + (contaNodos r)

folhas :: BTree a -> Int
folhas Empty = 0
folhas (Node x Empty Empty) = 1
folhas (Node x l r) = (folhas l) + (folhas r)

prune :: Int -> BTree a -> BTree a
prune 1 (Node x l r) = (Node x Empty Empty)
prune v (Node x l r) = (Node x (prune (v-1) l) (prune (v-1) r))

path :: [Bool] -> BTree a -> [a]
path [] _ = []
path _ Empty = []
path (x:xs) (Node y l r)| x = y : (path xs r)
                        | otherwise = y : (path xs l)

mirror :: BTree a -> BTree a
mirror Empty = Empty
mirror (Node x l r) = (Node x (mirror r) (mirror l))

zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c
zipWithBT _ Empty _ = Empty
zipWithBT _ _ Empty = Empty
zipWithBT f (Node x l1 r1) (Node y l2 r2) = Node (f x y) (zipWithBT f l1 l2) (zipWithBT f r1 r2)

unzipBT :: BTree (a,b,c) -> (BTree a,BTree b,BTree c)
unzipBT Empty = (Empty,Empty,Empty)
unzipBT (Node (b1,b2,b3) l r) = (Node b1 l1 r1,Node b2 l2 r2,Node b3 l3 r3)
            where
                (l1,l2,l3) = unzipBT l
                (r1,r2,r3) = unzipBT r

minimo :: Ord a => BTree a -> a
minimo (Node x Empty _) = x
minimo (Node _ l _) = minimo l

semMinimo :: Ord a => BTree a -> BTree a
semMinimo (Node x Empty r) = r
semMinimo (Node x l r) = (Node x (semMinimo l) r)

type Aluno = (Numero,Nome,Regime,Classificacao)
type Numero = Int
type Nome = String
data Regime = ORD | TE | MEL  deriving Show
data Classificacao = Aprov Int | Rep | Faltou deriving Show

type Turma = BTree Aluno  --  ́arvore bin ́aria de procura (ordenada por n ́umero)

inscNum :: Numero -> Turma -> Bool
inscNum _ Empty = False
inscNum n (Node (x,_,_,_) l r)| n == x = True 
                              | n >  x = inscNum n r
                              | n <  x = inscNum n l

inscNome :: Nome -> Turma -> Bool
inscNome _ Empty = False
inscNome n (Node (_,x,_,_) l r)| n == x = True 
                               | otherwise = (inscNome n l) | (inscNome n r)