module Exercicio8 where
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