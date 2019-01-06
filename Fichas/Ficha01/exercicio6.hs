module Exercicio6 where

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