module Ficha5 where

import Data.Char

e = [(x,6-x) | x <- [1..5]]

digitAlpha :: String -> (String,String)
digitAlpha s = aux (reverse s) ([],[])
            where
                aux:: String -> (String, String) -> (String, String)
                aux [] t = t
                aux (h:t) (l, n) | isAlpha h = aux t (h:l , n  )
                                 | isDigit h = aux t (l   , h:n)
                                 | otherwise = aux t (l   , n)

nzp :: [Int] -> (Int,Int,Int)
nzp l = aux l (0,0,0)
            where
                aux:: [Int] -> (Int,Int,Int) -> (Int,Int,Int)
                aux [] v = v
                aux (h:t) (n,z,p) | h <  0    =aux t (n+1,z  ,p  )
                                  | h == 0    =aux t (n  ,z+1,p  )
                                  | otherwise =aux t (n  ,z  ,p+1)

mydivMod :: Integral a => a -> a -> (a, a)
mydivMod x y = aux x y (0,0)
            where
               aux :: Integral a => a -> a -> (a, a) -> (a,a)
               aux x y (d,r) | x - y < 0 = (d, x)
                             | otherwise = aux (x-y) y (d + 1, r)

fromDigits :: [Int] -> Int
fromDigits []    = 0
fromDigits (h:t) = h*10^(length t) + fromDigits t

myFromDigits :: [Int] -> Int
myFromDigits l = aux l (length l - 1)
            where
                aux:: [Int] -> Int -> Int
                aux [] _    = 0
                aux (h:t) l = h*10 ^ l + aux t (l-1)

maxSumInit :: (Num a, Ord a) => [a] -> a
maxSumInit l = maximum [sum m | m <- inits l]

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

myfib :: Int -> Int
myfib v = aux v
            where
            	aux :: Int -> Int -> Int
            	aux _ = undefined