module Exercicio2 where

dobros:: [Float] -> [Float]
dobros [] = []
dobros (h:t) = 2*h : dobros t

numOcorre:: Char -> String -> Int
numOcorre a [] = 0
numOcorre a (h:t) = if a == h
                    then 1 + numOcorre a t
                    else numOcorre a t


positivos:: [Int] -> Bool
positivos [] = True
positivos (h:t) = h > 0 && positivos t

soPos:: [Int] -> [Int]
soPos [] = []
soPos (h:t) = if  h > 0 
              then h : soPos t
              else soPos t

somaNeg:: [Int] -> Int
somaNeg [] = 0
somaNeg (h:t) = if h < 0
                then h + somaNeg t
                else somaNeg t

tresUlt:: [a] -> [a]
tresUlt [] = []
tresUlt [x] = [x]
tresUlt [x,y] = [x,y]
tresUlt [x,y,z] = [x,y,z]
tresUlt (h:t) = tresUlt t

primeiros:: [(a,b)] -> [a]
primeiros [] = []
primeiros (h:t) = fst h : primeiros t
