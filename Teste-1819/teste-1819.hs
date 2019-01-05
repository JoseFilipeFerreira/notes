module Teste_1819  where

import Data.List
--1
--1a
elemIndices:: Eq a => a -> [a] -> [Int]
elemIndices = sort $ auxElemIndices 0 []
    where
        auxElemIndices :: Eq a => Int -> [Int] -> a -> [a] -> [Int]
        auxElemIndices p l n (h:t) | n == h    = auxElemIndices p+1 p:l n t
                                   | otherwise = auxElemIndices p+1   l n t

--1b
isSubsequenceOf::Eq a => [a] -> [a] -> Bool
isSubsequenceOf [] l = True
isSubsequenceOf l [] = False
isSubsequenceOf (h1:t1) (h2:t2) | h1 == h2  = isSubsequenceOf t1 t2
                                | otherwise = isSubsequenceOf (h1:t2) t2

--2
data BTree a = Empty | Node a (BTree a) (BTree a)
--2a
lookupAP:: Eq a => a -> BTree (a,b) -> Maybe b
lookupAP _ Empty = Nothing
lookupAP v (Node x l r) | v == fst x = Just snd v 
                        | v >  fst x = lookupAP v r
                        | otherwise  = lookupAP v l 

--2b
zipWithBT:: (a -> b -> c) -> BTree a -> BTree b -> BTree c
zipWithBT _ Empty Empty = Empty
zipWithBT f (Node x1 l1 r1) (Node x2 l2 r2) = Node (f x1 x2) (zipWithBT f l1 l2) (zipWithBT f r1 r2)

--3
digitAlpha::String -> (String, String)
digitAlpha = auxDigitAlpha ("", "")
    where
        auxDigitAlpha:: (String, String) -> String -> (String, String)
        auxDigitAlpha (d, a) (h:t) | isDigit h = (d ++ [h], a)
                                   | isAlpha t = (d, a++[h])

--4
data Seq a = Nil | Cons a (Seq a) | App (Seq a) (Seq a)
--4a
firstSeq:: Seq a -> a
firstSeq = head . seqToList

--4b
dropSeq:: Int -> Seq a -> Seq a
dropSeq 0 a = a
dropSeq n (Cons a)  = dropSeq n-1 a
dropSeq n (App l r) = App (dropSeq n -1 l) (dropSeq n-1 r)  

--4c
instance Show Seq where
    show = stringify . seqToList

stringify:: [a] -> String
stringify a = "<<" ++ intercalate "," (map show a) ">>"

seqToList:: Seq a -> [a]
seqToList Nil      = []
seqToList Cons a r = a:seqToList r
seqToList App  l r = seqToList l ++ seqToList r

--5
type Mat a = [[a]]
--5a
getElem::Mat a -> IO a
getElem mat = do x <- randomRIO (0, length mat - 1)
                 y <- randomRIO (0, length (head mat) -1)
                 return ((mat !! x) !! y)

--5b
magic:: Mat Int -> Bool
magic mat = vlins && vcols && allEqual [d1, d2, ncol, nlin]
    where
        size = length mat
        d1   = travel mat size (1, 1) (0, 0) 
        d2   = travel mat size (-1, 1)     (size-1, 0) 
        vcols = allEqual $ map sum mat
        ncol  = sum $ head mat
        vlins = allEqual $ map sum . transpose $ mat
        nlin  = head $ map sum . transpose $ mat

travel::Mat a -> Int -> (Int,Int) -> (Int, Int) -> Int
travel mat size (vx, vy) (px, py) | px == size || px < 0 = 0
                                  | py == size || py < 0 = 0
                                  | otherwise  = ((mat !! px) !! py) + travel mat size (vx, vy) (px + vx, py + vy)


allEqual :: Eq a => [a] -> Bool
allEqual []     = True
allEqual (x:xs) = all (== x) xs