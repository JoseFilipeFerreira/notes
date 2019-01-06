module Exercicio1 where

perimetro:: Double -> Double
perimetro x = 2*pi*x

dist:: (Double,Double) -> (Double,Double) -> Double
dist (x1,y1) (x2,y2) = sqrt ((x1-x2)^2 + (y1 - y2)^2)

primUlt::[a] -> (a,a)
primUlt a = (head a, last a)

multiplo:: Int -> Int -> Bool
multiplo m n = mod m n == 0

truncaImpar:: [a] -> [a]
truncaImpar x = if par (length x)
                then x
                else tail x
par:: Int -> Bool
par x = multiplo x 2
impar:: Int -> Bool
impar x = not(par x)

max2:: Double -> Double -> Double
max2 x y = if x > y
           then x
           else y

max3::Double -> Double -> Double -> Double
max3 x y z = max2 (max2 x y) z
