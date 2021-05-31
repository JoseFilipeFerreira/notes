module Ficha9 where

data Frac = F Integer Integer

normaliza:: Frac -> Frac
normaliza (F x y) | x > 0 && y < 0 = (F (-(div (abs x) d)) (div (abs y) d))
                  | x < 0 && y > 0 = (F (-(div (abs x) d)) (div (abs y) d))
                  | otherwise      = (F (  div (abs x) d)  (div (abs y) d))
            where
                d = mdc (abs x) (abs y)

mdc:: Integer -> Integer -> Integer
mdc n m | n == m    = n
        | n <  m    = mdc n (m-n)
        | otherwise = mdc (n-m) m

instance Eq Frac where
    f1 == f2 = x1 == x2 && y1 == y2
                where
                     (F x1 y1) = normaliza f1
                     (F x2 y2) = normaliza f2

instance Ord Frac where
    (F x1 y1) >  (F x2 y2) = (x1 * y2) >  (x2 * y1)
    (F x1 y1) <= (F x2 y2) = (x1 * y2) <= (x2 * y1)

instance Show Frac where
    show (F x y) = show x ++ ['/'] ++ show y

instance Num Frac where
    (F x1 y1) + (F x2 y2) = normaliza (F ((x1 * y2) + (y1 * x2)) (y1 * y2))
    (F x1 y1) - (F x2 y2) = normaliza (F ((x1 * y2) - (y1 * x2)) (y1 * y2))
    (F x1 y1) * (F x2 y2) = normaliza (F (x1 * x2)  (y1 * y2))
    abs    (F x y)        = (F (abs x) (abs y))
    negate (F x y)        = normaliza (F (-x) y)
    signum (F x y) | (x > 0 && y < 0) || (x < 0 && y > 0) = -1
                   | (x > 0 && y > 0) || (x < 0 && y < 0) =  1
                   | otherwise = 0
    fromInteger x = (F x 1)

fun f l = filter p l
            where
                p x = x > 2*f

data Exp a = Const a
           | Simetrico (Exp a)
           | Mais (Exp a) (Exp a)
           | Menos (Exp a) (Exp a)
           | Mult (Exp a) (Exp a)

instance Show a => Show (Exp a) where
                show (Const n)     = show n
                show (Simetrico n) = "-(" ++ show n ++ ")"
                show (Mais l r)    = "("  ++ show l ++ "+" ++ show r ++ ")"
                show (Menos l r)   = "("  ++ show l ++ "-" ++ show r ++ ")"
                show (Mult l r)    = "("  ++ show l ++ "*" ++ show r ++ ")"

instance  (Num a,Eq a) => Eq (Exp a) where
            x == y = (calcula x) == (calcula y)

calcula:: Num a => (Exp a) -> a
calcula (Const n)     = n
calcula (Simetrico n) = (-1) * calcula n
calcula (Mais l r)    =  (calcula l) + (calcula r)
calcula (Menos l r)   = (calcula l) - (calcula r)
calcula (Mult l r)    = (calcula l) * (calcula r)


instance (Ord a, Num a) => Num (Exp a) where
            x + y = Mais  x y
            x - y = Menos x y
            x * y = Mult  x y
            abs x | calcula x >= 0 = x
                  | otherwise      = Simetrico x
            negate x = Simetrico x
            signum x | calcula x == 0 = 0
                     | calcula x >  0 = 1
                     | calcula x <  0 = -1
            fromInteger x = Const (fromInteger x)
