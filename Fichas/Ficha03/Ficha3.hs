module Ficha1 where
import Data.List
-- | Exercício 1 a
(><):: Int -> Int -> Int
0 >< _ = 0
_ >< 0 = 0
x >< y = x + (x >< (y-1))

-- | Exercício 1 b
divmod::Int -> Int -> Int
divmod x y | x >= y    = 1 + (divmod (x - y) y)
           | otherwise = 0

-- | Exercício 1  c
power:: Int -> Int -> Int
power x 0 = 1
power x y = x * (power x (y - 1))


type Polinomio = [Monomio]
type Monomio   = (Float, Int)

-- | Exercício 2 a
conta:: Int -> Polinomio -> Int
conta _ []                = 0
conta x (h:t)| x == snd h = 1 + conta x t
             | otherwise  = conta x t

-- | Exercício 2 b
grau:: Polinomio -> Int
grau p = last (sort (aux p))
        where 
            aux::Polinomio -> [Int]
            aux []    = []
            aux (h:t) = (snd h) : aux t 

-- | Exercicio 2 c
selgrau:: Int -> Polinomio -> Polinomio
selgrau _ [] = []
selgrau x (h:t) | x == snd h = h : selgrau x t
                | otherwise  = selgrau x t 

-- | Exercicio 2 c
deriv:: Polinomio -> Polinomio
deriv [] = []
deriv ((x,y):t) | (y-1) >= 0 = (((fromIntegral y) * x) , (y-1)) : deriv t
                | (y-1) <  0 = deriv t

-- | Exercicio 2 e
calcula::Float -> Polinomio -> Float
calcula n [(x,y)]   = x * (n ^ y)
calcula n ((x,y):t) = x * (n ^ y) + calcula n t

-- | Exercicio 2 f
simp::Polinomio -> Polinomio
simp [] = []
simp ((x,y):t) | y == 0    = simp t
               | otherwise = (x,y): (simp t)

-- | Exercicio 2 g
mult::Monomio -> Polinomio -> Polinomio
mult (x1,y1) [(x2,y2)]   = [(x1 * x2, y1 + y2)]
mult (x1,y1) ((x2,y2):t) = (x1 * x2, y1 + y2) : mult (x1,y1) t

-- | Exercicio 2 h
normaliza:: Polinomio -> Polinomio
normaliza p = aux (grau p) p
    where
        aux::Int -> Polinomio -> Polinomio
        aux _ [] = []
        aux (-1) _ = []
        aux g p  | (selgrau g p) == [] = (aux (g-1) p)
                 | otherwise           = (somap (selgrau g p)) : (aux (g-1) p)
          
somap:: Polinomio -> Monomio
somap [(x,y)] = (x,y)
somap ((x1,y1):(x2,y2):t) = somap(((x1 + x2),y1):t)

soma::Polinomio -> Polinomio -> Polinomio
soma p1 p2 = normaliza (p1 ++ p2)



deleteAll:: Polinomio -> Polinomio -> Polinomio
deleteAll [] p = p
deleteAll (h:t) p = deleteAll t (delete h p)

deletem:: Monomio -> Polinomio -> Polinomio
deletem _ [] = []
deletem (x1,y1) ((x2,y2):t) | y1 == y2  = (deletem (x1,y1) t)
                            | otherwise = ((x2,y2) : (deletem (x1,y1) t))



