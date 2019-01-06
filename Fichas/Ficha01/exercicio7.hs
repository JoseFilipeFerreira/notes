module Exercicio7 where

max2:: Double -> Double -> Double
max2 x y = if x > y
           then x
           else y

max3::Double -> Double -> Double -> Double
max3 x y z = max2 (max2 x y) z

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
