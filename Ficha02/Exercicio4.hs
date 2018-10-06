module Exercicio4 where

import Data.List


primeiros:: [(a,b)] -> [a]
primeiros [] = []
primeiros (h:t) = fst h : primeiros t


-- |Devolve numa lista os segundos elementos dos tuplos numa lista
segundos:: [(a,b)] -> [b]
segundos [] = []
segundos (h:t) = snd h : segundos t

-- |Testa se algum dos primeiros elementos de tuplos contidos numa lista é par  
nosPrimeiros::(Eq a) => a -> [(a,b)] -> Bool
nosPrimeiros x [] = False
nosPrimeiros x (h:t) = ((x == (fst h)) || (nosPrimeiros x t))

-- |Devolve o menor primeiro elemento de pares contidos numa lista
minFst:: (Ord a) => [(a,b)] -> a
minFst x = head(sort(primeiros x))

-- |Devolve o componente associado ao menor primeiro elemento de um conjunto de pares contidos numa lista
sndMinFist:: (Ord a) => [(a,b)] -> b
sndMinFist [] = undefined
sndMinFist (h:t) = if minFst(h:t) == fst h
                   then snd h
                   else sndMinFist t

-- |Devolve a soma de uma lista de triplos componente a componente
sumTriplos:: (Num a, Num b, Num c) => [(a,b,c)] -> (a,b,c)
sumTriplos [] = (0,0,0)
sumTriplos ((x,y,z):t) = (x + posfst (sumTriplos t), y + possnd (sumTriplos t),z + postrd (sumTriplos t))


-- |Devolve o primeiro elemento de um triplo
posfst::(a,b,c) -> a
posfst (x, _, _) = x

-- |Devolve o segundo elemento de um triplo
possnd::(a,b,c) -> b
possnd (_, x, _) = x

-- |Devolve o terceiro elemento de um triplo
postrd::(a,b,c) -> c
postrd (_, _, x) = x

-- |Devolve o maior número do triplo que resulta da soma de uma lista de triplos componente a componente
maxTriplo::(Ord a, Num a) => [(a,a,a)] -> a
maxTriplo l | x >= y && x >= z = x 
            | y >= x && y >= z = y
            | z >= x && z >= y = z
                where x = posfst (sumTriplos l)
                      y = possnd (sumTriplos l)
                      z = postrd (sumTriplos l)
