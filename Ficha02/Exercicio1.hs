module Exercicio1 where

funA:: [Double] -> Double
funA [] = 0
funA (y:ys) = (y^2) + (funA ys)

funB::[Int] -> [Int]
funB [] = []
funB (h:t) = if mod h 2 == 0
             then h:(funB t)
             else funB t

funC:: [a] -> [a]
funC (x:y:t) = funC t
funC [x] = []
funC [] = []

funD l = g [] l
g l [] = l
g l [h:t] = g (h:l) t