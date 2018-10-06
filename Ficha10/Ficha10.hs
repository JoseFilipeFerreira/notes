module Ficha10 where

import System.Random
import Data.List

bingo :: IO()
bingo = do let l = [1..90]
           bingoaux l

bingoaux::(Eq a,Show a) => [a] -> IO()
bingoaux [] = return ()
bingoaux l  = do i <- randomRIO (0, length l-1)
                 getChar
                 putStrLn (show (l!!i))
                 bingoaux (delete (l!!i) l)

data Aposta = Ap [Int] (Int,Int)

valida :: Aposta -> Bool
valida (Ap l (e1,e2)) = (length l == 5)
                     && e1 /= e2
                     && l1 /= l2
                     && l1 /= l3
                     && l1 /= l4
                     && l1 /= l5
                     && l2 /= l3
                     && l2 /= l4
                     && l2 /= l5
                     && l3 /= l4
                     && l3 /= l5
                     && l4 /= l5
                     && e1 > 0
                     && e1 < 6
                     && e2 > 0
                     && e2 < 6
                     && l1 > 0
                     && l2 > 0
                     && l3 > 0
                     && l4 > 0
                     && l5 > 0
                     && l1 < 51
                     && l2 < 51
                     && l3 < 51
                     && l4 < 51
                     && l5 < 51
            where
                l1 = l !!0 
                l2 = l !!1 
                l3 = l !!2 
                l4 = l !!3
                l5 = l !!4

comuns :: Aposta -> Aposta -> (Int,Int)
comuns (Ap l1 e1) (Ap l2 e2) = (comparaNum l1 l2, comparaES e1 e2)
              where
                   comparaNum::[Int] -> [Int] -> Int
                   comparaNum _  _= 1

                   comparaES:: (Int,Int) -> (Int,Int) -> Int
                   comparaES _  _= 1


leAposta::IO Aposta
leAposta = do putStrLn"Aposta: "
              a <- getLine
              let ns = map read (words a) :: [Int]
              if (length ns /= 7)
                  then leAposta
                  else return (Ap (take 5 ns) (ns !! 6, ns !! 7))




    