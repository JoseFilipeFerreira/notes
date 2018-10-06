module Exercicio3 where


import Data.Char

isLowerN:: Char -> Bool
isLowerN x = ord x >= 97 && ord x <= 122

isDigitN:: Char -> Bool
isDigitN x = ord x >= 48 && ord x <= 57

digitToIntN:: Char -> Int
digitToIntN x = (ord x) - 48



soDigits:: [Char] -> [Char]
soDigits [] = []
soDigits (h:t) = if isDigitN h
                 then h : soDigits t
                 else soDigits t

minusculas:: [Char] -> Int
minusculas [] = 0
minusculas (h:t) = if isLowerN h
                   then 1 + minusculas t
                   else minusculas t

nums:: String -> [Int]
nums "" = []
nums (h:t) = if isDigitN h
             then digitToIntN h : nums t
             else nums t