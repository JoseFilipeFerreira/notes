module Exercicio3 where

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