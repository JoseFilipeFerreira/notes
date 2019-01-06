module Ficha4 where
import Data.Maybe

type Poligonal = [Ponto]

data Ponto = Cartesiano Double Double | Polar Double Double deriving (Show,Eq)

posx:: Ponto -> Double
posx (Cartesiano x _) = x 
posx (Polar x a) = x * cos (a)

posy:: Ponto -> Double
posy (Cartesiano _ y) = y
posy (Polar x a) = x * sin (a)

raio:: Ponto -> Double
raio (Cartesiano x y) = sqrt((x^2) + (y^2))
raio (Polar x _ ) = x

angulo:: Ponto -> Double
angulo (Cartesiano x y) = atan(y/x)
angulo (Polar _ a) = a

distPonto:: Ponto -> Ponto -> Double
distPonto a b = sqrt(((posx a - posx b)^2) + ((posy a - posy b)^2))

conv2polar::Ponto -> Ponto
conv2polar (Cartesiano x y) = (Polar (distPonto (Cartesiano 0 0) (Cartesiano x y)) (angulo (Cartesiano x y)))
conv2polar (Polar x y) = (Polar x y)

data Figura = Circulo Ponto Double 
            | Retangulo Ponto Ponto
            | Triangulo Ponto Ponto Ponto 
                deriving (Show,Eq)

area:: Figura -> Double
area (Circulo _ r) = pi*(r^2) 
area (Triangulo p1 p2 p3) = sqrt(s*(s-a)*(s-b)*(s-c))
    where 
        a = distPonto p1 p2
        b = distPonto p1 p3
        c = distPonto p2 p3
        s = (a+b+c)/2
area (Retangulo x y) = abs(posx x - posx y) * abs(posy x - posy y)


-- Exercicio 2 a
lenghtPoligono:: Poligonal -> Double
lenghtPoligono [] = 0
lenghtPoligono [x] = 0
lenghtPoligono (h:m:t) = (distPonto h m) + (lenghtPoligono(m:t))

-- Exercicio 2 c
triangula:: Poligonal -> [Figura]
-- triangula []       = []
-- triangula [x]      = []
-- triangula [x,y]    = []
triangula (x:y:z:t) = (Triangulo x y z) : (triangula (x:z:t))
triangula _         = []

-- Exercicio 2 d
areaPoligono:: Poligonal -> Double
areaPoligono x = aux (triangula x)
            where
                aux::[Figura] -> Double
                aux [] = 0
                aux (h:t) = (area h) + (aux t)

-- Exercicio 2 e
mover :: Poligonal -> Ponto -> Poligonal
mover (h:t) p = aux (h:t) (((posx p) - (posx h)),((posy p) - (posy h)))
            where
                aux::Poligonal -> (Double,Double) -> Poligonal
                aux [] _ = []
                aux (h:t) (x,y) = ( (translate h (x,y)) : (aux t (x,y)) )
                   
translate::Ponto -> (Double,Double) -> Ponto
translate p (x,y) = (Cartesiano ((posx p) + x) ((posy p) + y) )

-- Exercicio 2 f
zoom:: Double -> Poligonal -> Poligonal
zoom _ []  = []
zoom _ [x] = []
zoom f (h:m:t) = ((dilata f (conv2polar h)) : zoom f (h:t))
                where
                    dilata:: Double -> Ponto -> Ponto
                    dilata f (Polar x y) = (Polar (f*x) y)

type Dia  = Int
type Mes  = Int
type Ano  = Int
type Nome = String

data Data = D Dia Mes Ano deriving Show
type TabDN = [(Nome,Data)]

-- Exercicio 4 a
procura:: Nome -> TabDN -> Maybe Data
procura _ [] = Nothing
procura v ((n,d):t)| v == n    = Just d
                   | otherwise = procura v t

-- Exercicio 4 b
idade::Data -> Nome -> TabDN -> Maybe Int
idade d n l | isNothing procurar = Nothing
            | otherwise               = Just (aux d fromJust procurar)
                 where
                 	aux:: Data -> Data -> Int
                 	aux (D d1 m1 a1) (D d2 m2 a2) | (m2 > m1) || ((m2 == m1) && (d2 > d1)) = (a2 - a1)
                 	                              | otherwise                              = (a2 - a1 - 1)
                 	procurar = procura n l