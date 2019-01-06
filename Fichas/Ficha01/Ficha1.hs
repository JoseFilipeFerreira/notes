module Ficha1 where

--exercicio 1

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


--exercicio 2

nRaizes:: Double -> Double -> Double -> Int
nRaizes a b c = let b4ac = (b^2 -4*a*c) in if b4ac == 0
                                           then 1
                                           else if b4ac>0
                                                then 2
                                                else 0)

raizes:: Double -> Double -> Double -> [Double]
raizes a b c = if nRaizes a b c /= 0
                    then if nRaizes a b c == 2
                         then [(((-b) + sqrt((b^2) - 4*a*c))/(2*a)), (((-b) - sqrt((b^2) - (4*a*c)))/(2*a))]
                         else [((-b)/(2*a))]
               else []

--exercicio 3

type Hora = (Int,Int)

testHora:: Hora -> Bool
testHora (x,y) = ((x >= 0) && (x <= 24) && (y >= 0) && (y <= 60))

compHora:: Hora -> Hora -> Hora
compHora (a,b) (c,d) = if (a>c || (a==c && b>d))
                       then (a,b)
                       else (c,d)  

convertMin::Hora -> Int
convertMin (x,y) = x*60 + y

convertHora:: Int -> Hora
convertHora x = verHora((div x 60), x - (div x 60) *60)
verHora:: Hora -> Hora
verHora (x,y) = if x >= 24
                then ((div x 24 - 1), y)
                else (x,y)


difHora:: Hora -> Hora -> Int
difHora (x1,y1) (x2,y2) = convertMin(x2,y2) - convertMin(x1,y1)

addHora:: Hora -> Int -> Hora
addHora (x,y) a = convertHora (convertMin (x,y) + a)

--exercicio 4

data HoraH = H Int Int  deriving (Show, Eq)

testHoraH:: HoraH -> Bool
testHoraH (H x y) = ((x >= 0) && (x <= 24) && (y >= 0) && (y <= 60))

compHoraH:: HoraH -> HoraH -> HoraH
compHoraH (H a b) (H c d) = if (a>c || (a==c && b>d))
                            then H a b
                            else H c d 

convertMinH::HoraH -> Int
convertMinH (H x y) = x*60 + y

convertHoraH:: Int -> HoraH
convertHoraH x = verHoraH(H (div x 60) (x - (div x 60) *60))
verHoraH:: HoraH -> HoraH
verHoraH (H x y) = if x >= 24
                   then (H (div x 24 - 1) y)
                   else H x y

difHoraH:: HoraH -> HoraH -> Int
difHoraH (H x1 y1) (H x2 y2) = abs(convertMinH(H x2 y2) - convertMinH(H x1 y1))

addHoraH:: HoraH -> Int -> HoraH
addHoraH (H x y) a = convertHoraH (convertMinH (H x y) + a)

--exercicio 5

data Semaforo = Verde | Amarelo | Vermelho deriving (Show,Eq)

next:: Semaforo -> Semaforo
next Verde = Amarelo
next Amarelo = Vermelho
next Vermelho = Verde

stop:: Semaforo -> Bool
stop Vermelho = True
stop _ = False


safe:: Semaforo -> Semaforo -> Bool
safe x y = (not(stop x) && (stop y)) || ((stop x) && not(stop y)) --xor gate

--exercicio 6

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

--exercicio 7

data Figura = Circulo Ponto Double 
            | Retangulo Ponto Ponto
            | Triangulo Ponto Ponto Ponto 
                deriving (Show,Eq)

poligono:: Figura -> Bool
poligono (Circulo _ r) = r > 0
poligono (Retangulo x y) = posx x /= posx y && posy x /= posy y
poligono (Triangulo x y z) = ((abs(b - c)) < a && a < (b + c))
                          || ((abs(a - c)) < b && b < (a + c))
                          || ((abs(a - b)) < c && c < (a + b))
        where 
            a = (distPonto x y)
            b = (distPonto x z)
            c = (distPonto y z)

vertices:: Figura -> [Ponto]
vertices (Circulo _ _) = []
vertices (Retangulo x y) = [x , y , (Cartesiano x1 (y1 + vy)) , (Cartesiano (x1 + vx) y1)  ]
        where
            x1 = posx x
            y1 = posy x
            vx = posx y - posx x
            vy = posy y - posy x
vertices (Triangulo x y z) = [x, y, z]


area:: Figura -> Double
area (Circulo _ r) = pi*(r^2) 
area (Triangulo p1 p2 p3) = sqrt(s*(s-a)*(s-b)*(s-c))
    where 
        a = distPonto p1 p2
        b = distPonto p1 p3
        c = distPonto p2 p3
        s = (a+b+c)/2
area (Retangulo x y) = abs(posx x - posx y) * abs(posy x - posy y)

--exercicio 8

import Data.Char

isLowerN:: Char -> Bool
isLowerN x = ord x >= 97 && ord x <= 122

isDigitN:: Char -> Bool
isDigitN x = ord x >= 48 && ord x <= 57

isAlphaN:: Char -> Bool
isAlphaN x = isLowerN x || (ord x >= 65 && ord x <= 90)

toUpperN:: Char -> Char
toUpperN x = if isLowerN x
             then chr ((ord x) - 32)  
             else x

intToDigitN:: Int -> Char
intToDigitN x = chr (48 + x)

digitToIntN:: Char -> Int
digitToIntN x = (ord x) - 48
