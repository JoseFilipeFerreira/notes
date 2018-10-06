module Exercicio5 where

data Semaforo = Verde | Amarelo | Vermelho deriving (Show,Eq)

next:: Semaforo -> Semaforo
next Verde = Amarelo
next Amarelo = Vermelho
next Vermelho = Verde

stop:: Semaforo -> Bool
stop x = if x == Vermelho
         then False
         else True

safe:: Semaforo -> Semaforo -> Bool
safe x y = (not(stop x) && (stop y)) || ((stop x) && not(stop y)) --xor gate