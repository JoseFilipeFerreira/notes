-- | As famosas 50 questões
module Questoes1 where
import Data.List
import Data.Char
-- |exercicio 1
myenumFromTo :: Int -> Int -> [Int]
myenumFromTo x y | x == y    = [x]
                 | x /= y    = (x: (enumFromTo (x+1) y))

-- |exercicio 2
myenumFromThenTo :: Int -> Int -> Int -> [Int]
myenumFromThenTo x y z | x == z    = [x]
                       | x >= z    = []
                       | otherwise = (x: (enumFromThenTo y (2*y - x) z))

-- |exercicio 3
addList:: [a] -> [a] -> [a]
addList [] x = x
addList h t = (head h) : addList (tail h) t

-- |exercicio 4
posfinder :: [a] -> Int -> a
posfinder (h:t) 0 = h
posfinder (h:t) p = posfinder t (p-1)

-- |exercicio 5
myreverse:: [a] -> [a]
myreverse [] = []
myreverse x = last x : myreverse (init x)

-- |exercicio 6
mytake ::[a] -> Int -> [a]
mytake l x | x == 0 = []
           | null l = []
           | x >= 0 = (head l) : mytake (tail l) (x - 1)

-- |exercicio 7
mydrop:: Int -> [a] -> [a]
mydrop _ []    = []
mydrop 0 x     = x
mydrop x (h:t) = mydrop (x-1) t

-- |exercicio 8

myzip:: [a] -> [b] -> [(a,b)]
myzip [] _ = []
myzip _ [] = []
myzip (h1:t1) (h2:t2) = (h1,h2) : (myzip t1 t2)

-- |exercicio 9
myelem:: Eq a => a -> [a] -> Bool
myelem _ []    = False
myelem x (h:t) = x == h || myelem x t

-- |exercicio 10
myreplicate:: Int -> a -> [a]
myreplicate 0 _ = []
myreplicate x h = h : myreplicate (x-1) h

-- |exercicio 11
myinterperse:: a -> [a] -> [a]
myinterperse _ []       = []
myinterperse x (h:[])   = (h:x:[])
myinterperse x (h:m:[]) = (h:x:m:[])
myinterperse x (h:t)    = (h : x : (myinterperse x t))

--exercicio 12
mygroup:: Eq a => [a] -> [[a]]
mygroup [] = []
mygroup (h:t) = e : (mygroup d)
    where
        (e, d) = aux ([h], t)
        aux:: Eq a => ([a], [a]) -> ([a], [a])
        aux (l, []) = (l, [])
        aux ((h1:t1), (h2:t2)) | h1 == h2   = aux ((h1:(h2:t1)), t2)
                               | otherwise = ((h1:t1), (h2:t2))

-- |exercicio 13
myconcat::[[a]] -> [a]
myconcat [] = []
myconcat (h:t) = h ++ myconcat t

-- |exercicio 14
myinits:: [a] -> [[a]]
myinits x = reverse (aux (x) (length x))
        where 
            aux:: [a] -> Int -> [[a]]
            aux _ 0 = [[]]
            aux l c = take c l : aux l (c-1)


-- |exercicio 15
mytails:: [a] ->[[a]]
mytails [] = [[]]
mytails (x:[]) = [[x],[]]
mytails (h:m:t) = ((h:m:t) : (mytails (m:t)))

-- |exercicio 16
myisPrefixOf:: Eq a => [a] -> [a] -> Bool
myisPrefixOf [] _ = True
myisPrefixOf _ [] = False
myisPrefixOf (h:t) (h1:t1) | h == h1 = myisPrefixOf t t1
                           | h /= h1 = False

--exercicio 17
myIsSuffixOf::Eq a => [a] -> [a] -> Bool
myIsSuffixOf [] _ = True
myIsSuffixOf _ [] = False
myIsSuffixOf (x:xs) (y:ys) | x == y    = myIsSuffixOf xs ys
                           | otherwise = myIsSuffixOf (x:xs) ys 

-- |exercicio 18
myisSubsequenceOf:: Eq a =>  [a] -> [a] -> Bool
myisSubsequenceOf _ [] = False
myisSubsequenceOf [] _ = True
myisSubsequenceOf (h:t) (h1:t1) | h == h1 = myisSubsequenceOf t t1
                                | h /= h1 = myisSubsequenceOf (h:t) t1  

--exercicio 19
{-
myElemIndices:: Eq a => a -> [a] -> [Int]
myElemIndices n l = myElemIndices' 0 n l 

myElemIndices':: Eq a => Int -> a -> [a] -> [Int]
myElemIndices' i n [] = []
myElemIndices' i n (h:t) | h == t    = i : myElemIndices' i n
                         | otherwise = myElemIndices' (i+1) n t
                         -}

--exercicio 20


-- |exercicio 21
mydelete::Eq a => a -> [a] -> [a]
mydelete x (h:t)| h == x    = t
                | otherwise = h : mydelete x t

-- |exercicio 22
mykick:: Eq a => [a] -> [a] -> [a]
mykick l [] = l
mykick l (h:t) = mykick (aux l h) t
            where
                aux::Eq a => [a] -> a -> [a]
                aux (h:t) x | h == x    = t
                            | otherwise = (h : (aux t x)) 


-- |exercicio 23
myunion:: Eq a => [a] -> [a] -> [a]
myunion l l1 = l ++ aux l1 l 
            where
                aux::Eq a => [a] -> [a] -> [a]
                aux l [] = l
                aux l (h:t) = aux (aux2 l h) t
                    where
                        aux2::Eq a => [a] -> a -> [a]
                        aux2 (h:t) x | h == x    = t
                                     | otherwise = (h : (aux2 t x)) 
-- myunion x y = x ++  (y \\ x)

--exercicio 24


--exercicio 25


-- |exercicio 26
myunwords::[String] -> String
myunwords []    = ""
myunwords [x]   = x
myunwords (h:t) = h ++ " " ++ myunwords t

-- |exercicio 27
myunlines:: [String] -> String
myunlines [] = ""
myunlines (h:t) = h ++ "\n" ++ myunlines t


--exercicio 28


--exercicio 29


-- |exercicio 30
myalgarismos:: [Char] -> [Char]
myalgarismos [] = []
myalgarismos (h:t) | isDigit h = h : myalgarismos t
                   | otherwise =  myalgarismos t

-- |exercicio 31
posImpares::[a] -> [a]
posImpares [] = []
posImpares [h] = []
posImpares (h:m:t) = m : posImpares t

-- |exercicio 32
posPares::[a] -> [a]
posPares [] = []
posPares [h] = [h]
posPares (h:m:t) = h : posPares t

-- |exercicio 33
isSorted:: Ord a => [a] -> Bool
isSorted [h] = True
isSorted (h:m:t) = (h <= m) && isSorted (m:t)  

-- |exercicio 34
iSort:: Ord a => [a] -> [a]
iSort [] = []
iSort [h] = [h]
iSort (h:t) = insert h (iSort t) 

-- |exercicio 35
-- NOTA: import Data.Char necessário para o funcionamentoto
menor:: String -> String -> Bool
menor [] _ = True
menor _ [] = False
menor (h1:t1) (h2:t2) = ((ord h1) <= (ord h2)) && (menor t1 t2)

{- Caso não se possa utilizar import data.Char
            where
                aux:: Char -> Int
                aux c | c = 'a'  || c = 'A' = 1
                      | c = 'b'  || c = 'B' = 2
                      | c = 'c'  || c = 'C' = 3
                      | c = 'd'  || c = 'D' = 4
                      | c = 'e'  || c = 'E' = 5
                      | c = 'f'  || c = 'F' = 6
                      | c = 'g'  || c = 'G' = 7
                      | c = 'h'  || c = 'H' = 8
                      | c = 'i'  || c = 'I' = 9
                      | c = 'j'  || c = 'J' = 10
                      | c = 'k'  || c = 'K' = 11
                      | c = 'l'  || c = 'L' = 12
                      | c = 'm'  || c = 'M' = 13
                      | c = 'n'  || c = 'N' = 14
                      | c = 'o'  || c = 'O' = 15
                      | c = 'p'  || c = 'P' = 16
                      | c = 'q'  || c = 'Q' = 17
                      | c = 'r'  || c = 'R' = 18
                      | c = 's'  || c = 'S' = 19
                      | c = 't'  || c = 'T' = 20
                      | c = 'u'  || c = 'U' = 21
                      | c = 'v'  || c = 'V' = 22
                      | c = 'x'  || c = 'X' = 23
                      | c = 'w'  || c = 'W' = 24
                      | c = 'y'  || c = 'Y' = 25
                      | c = 'z'  || c = 'Z' = 26
-}

-- |exercicio 36
elemMSet:: Eq a => a -> [(a,Int)] -> Bool
elemMSet _ [] = False
elemMSet v ((x,_):t) | (v == x)  = True
                     | otherwise = elemMSet v t

-- |exercicio 37
lengthMSet:: [(a,Int)] -> Int
lengthMSet []        = 0
lengthMSet ((_,y):t) = y + (lengthMSet t) 

-- |exercicio 38
convertMSet:: [(a,Int)] -> [a]
convertMSet []        = []
convertMSet ((x,y):t) = (aux x y) ++ convertMSet t
            where
                aux:: a -> Int -> [a]
                aux _ 0 = []
                aux x v = x : (aux x (v-1)) 

-- |exercicio 39
insereMSet:: Eq a => a -> [(a,Int)] -> [(a,Int)]
insereMSet x []                    = [(x,1)]
insereMSet v ((x,y):t) | (v == x)  = (x,(y + 1)) : t
                       | otherwise = (x,y) : (insereMSet v t) 

-- |exercicio 40
removeMSet:: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet v [] = []
removeMSet v ((x,y):t) | v == x = (x,(y-1)) : t
                       | otherwise = (x,y) : (removeMSet v t)

--exercicio 41
constroiMSet:: Ord a => [a] -> [(a,Int)]
constroiMSet []    = []
constroiMSet [v]   = [(v,1)]
constroiMSet (h:t) = reverse (aux h (reverse (constroiMSet t)))
            where
                aux:: Ord a => a -> [(a,Int)] -> [(a,Int)]
                aux v []                    = [(v,1)]
                aux v ((x,y):t) | v == x    = (x, (y+1)):t 
                                | otherwise = (x,y) : (aux v t)
-- | exercicio 42
{-
myPartitionEithers::[Either a b] -> ([a,b])
myPartitionEithers []    = ([],[])
myPartitionEithers (Left a:t)  = (a:l,r) 
                    where
                        (l,r) = myPartitionEithers t 
myPartitionEithers (Right a:t) = (l, a:r) 
                    where
                        (l,r) = myPartitionEithers t 
                        -} 

--exercicio 43
myCatMaybes:: [Maybe a] -> [a]
myCatMaybes = undefined

-- |exercicio 44
data Movimento = Norte | Sul | Este | Oeste deriving Show

posicao:: (Int, Int) -> [Movimento] -> (Int,Int)
posicao (x,y) [] = (x,y)
posicao (x,y) (h:t) = posicao (aux (x,y) h) t
           where
            aux::(Int,Int) -> Movimento -> (Int,Int)
            aux (x,y) Norte = (x  , y+1)
            aux (x,y) Sul   = (x  , y-1)
            aux (x,y) Este  = (x+1, y  )
            aux (x,y) Oeste = (x-1, y  )

-- |exercicio 45
caminho:: (Int,Int) -> (Int,Int) -> [Movimento]
caminho (x1,y1) (x2,y2) = aux1 (x2 - x1) ++ aux2 (y2 -y1)
            where
                aux1:: Int -> [Movimento]
                aux1 x | x >= 0 = aux3 Este x
                       | x <  0 = aux3 Oeste (-x)
                aux2:: Int -> [Movimento]
                aux2 x | x >= 0 = aux3 Norte x
                       | x <  0 = aux3 Sul (-x)
                aux3:: Movimento -> Int -> [Movimento]
                aux3 _ 0 = []
                aux3 m x = m : (aux3 m (x-1))

--exercicio 46
vertical:: [Movimento] -> Bool
vertical [h]   = (aux h)
            where
              aux::Movimento -> Bool
              aux Norte = True
              aux Sul   = True
              aux _     = False
vertical (h:t) = (aux h) && vertical t
            where
              aux::Movimento -> Bool
              aux Norte = True
              aux Sul   = True
              aux _     = False

--exercicio 47
data Posicao = Pos Int Int deriving Show

{-
maisCentral::[Posicao] -> Posicao
maisCentral [p] = p
maisCentral (h:m:t) | (dist h) >= (dist m) = maisCentral (m:t)
                    | otherwise            = maisCentral (h:t) 
            where
              dist::Posicao -> Double
              dist (Pos x y) = sqrt(fromInteger ((x*x) + (y*y)))
              -}

--exercicio 48


--exercicio 49

--exercicio 50
