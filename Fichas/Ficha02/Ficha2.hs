-- |Conjunto de funções da ficha 2
module Ficha2 where
import Data.Char
import Data.List
-- exercicio 1
-- | Soma dos quadrados dos elementos de uma lista
funA:: [Double] -> Double
funA [] = 0
funA (y:ys) = (y^2) + (funA ys)
-- | Devolve uma lista com os elementos pares de uma lita que lhe é dada
funB::[Int] -> [Int]
funB [] = []
funB (h:t) = if mod h 2 == 0
             then h:(funB t)
             else funB t
-- | Função que devolve uma lista vazia de forma recursiva
funC:: [a] -> [a]
funC (x:y:t) = funC t
funC [x] = []
funC [] = []

-- | Função reverse
funD l = g [] l
g l [] = l
g l (h:t) = g (h:l) t


-- = Heading exercicio 2

-- |Devolve uma lista que em que cada elemento é o dobro de cada elemento da lista que lhe é dado
dobros:: [Float] -> [Float]
dobros [] = []
dobros (h:t) = 2*h : dobros t

-- |Devolve o número de vezes que um caracter ocorre numa string
numOcorre:: Char -> String -> Int
numOcorre a [] = 0
numOcorre a (h:t) = if a == h
                    then 1 + numOcorre a t
                    else numOcorre a t

-- |Verifica se uma lista só tem elementos positivos
positivos:: [Int] -> Bool
positivos [] = True
positivos (h:t) = h > 0 && positivos t

-- |retira os elementos não positivos de uma lista de inteiros
soPos:: [Int] -> [Int]
soPos [] = []
soPos (h:t) = if  h > 0 
              then h : soPos t
              else soPos t

-- |soma todos os elementos negativos de uma lista
somaNeg:: [Int] -> Int
somaNeg [] = 0
somaNeg (h:t) = if h < 0
                then h + somaNeg t
                else somaNeg t

-- |devolve os últimos três elemenos de uma lista
tresUlt:: [a] -> [a]
tresUlt [] = []
tresUlt [x] = [x]
tresUlt [x,y] = [x,y]
tresUlt [x,y,z] = [x,y,z]
tresUlt (h:t) = tresUlt t

-- |recebe uma lista de pares e devolve os primeiros elementos desses pares numa lista
primeiros:: [(a,b)] -> [a]
primeiros [] = []
primeiros (h:t) = fst h : primeiros t

-- = Heading exercicio 3

-- |Verifica se um caracter é uma letra minúscula 
isLowerN:: Char -> Bool
isLowerN x = ord x >= 97 && ord x <= 122

-- |Verifica se um caracter é um digito
isDigitN:: Char -> Bool
isDigitN x = ord x >= 48 && ord x <= 57

-- |comverte de um digito de caracter para inteiro
digitToIntN:: Char -> Int
digitToIntN x = (ord x) - 48


-- |recebe uma lista de caracteres e seleciona os que são algarismos
soDigits:: [Char] -> [Char]
soDigits [] = []
soDigits (h:t) = if isDigitN h
                 then h : soDigits t
                 else soDigits t

-- |recebe uma lista de caracteres e conta quantos é que são minusculas
minusculas:: [Char] -> Int
minusculas [] = 0
minusculas (h:t) = if isLowerN h
                   then 1 + minusculas t
                   else minusculas t

-- |recebe uma string e devolve uma lista com os algarismos que ocorrem nessa string
nums:: String -> [Int]
nums "" = []
nums (h:t) = if isDigitN h
             then digitToIntN h : nums t
             else nums t

-- = Heading exercicio 4


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

-- |Devolve o maior número do triplo que resulta da soma de uma lista de triplos componente a componente
maxTriplo::(Ord a, Num a) => [(a,a,a)] -> a
maxTriplo l | x >= y && x >= z = x 
            | y >= x && y >= z = y
            | z >= x && z >= y = z
                where x = posfst (sumTriplos l)
                      y = possnd (sumTriplos l)
                      z = postrd (sumTriplos l)

-- |Devolve o primeiro elemento de um triplo
posfst::(a,b,c) -> a
posfst (x, _, _) = x

-- |Devolve o segundo elemento de um triplo
possnd::(a,b,c) -> b
possnd (_, x, _) = x

-- |Devolve o terceiro elemento de um triplo
postrd::(a,b,c) -> c
postrd (_, _, x) = x