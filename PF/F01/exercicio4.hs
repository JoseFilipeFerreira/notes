module Exercicio4 where

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
