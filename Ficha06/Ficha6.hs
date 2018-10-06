module Ficha6 where


any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (x:xs) = f x || any' f xs

zipWith' :: (a->b->c) -> [a] -> [b] -> [c]
zipWith' f [] _ = []
zipWith' f _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

takeWhile' :: (a->Bool) -> [a] -> [a]
takeWhile' f [] = []
takeWhile' f (x:xs) | f x = x : takeWhile' f xs  
                    | otherwise = []


dropWhile' :: (a->Bool) -> [a] -> [a]
dropWhile' f [] = []
dropWhile' f (x:xs) | f x = dropWhile' f xs  
                    | otherwise = xs


type Polinomio = [Monomio]
type Monomio = (Float,Int)

selgrau :: Int -> Polinomio -> Polinomio
selgrau i pol = filter f pol
            where
                f (c,e) = e == i

deriv :: Polinomio -> Polinomio
deriv p = map aux p
            where
                aux (x,y)= (x* (fromIntegral y), y-1)

{-
calcula :: Float -> Polinomio -> Float
calcula 
            where
            	f v (x,y) = x * v^y
-}

simp :: Polinomio -> Polinomio
simp p = filter aux p
            where
                aux (x,y)= y /= 0

-- | Somar todos os elementos de uma lista
sum':: [Int] -> Int
sum' = foldr (+) 0

-- | Multiplicar todos os elementos de uma lista
mult':: [Int] -> Int
mult' = foldr (*) 1

grau:: Polinomio -> Int
grau = foldr f 0
            where 
                f::Monomio -> Int -> Int
                f (_,e) g | e > g = e
                          | otherwise = g

conta :: Int -> Polinomio -> Int
conta n = foldr f 0
            where
                f:: Monomio -> Int  -> Int
                f (_,e) c | e == n = 1 + c
                          | otherwise = c

