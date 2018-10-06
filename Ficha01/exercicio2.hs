module Exercicio2 where

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