module Ficha1  where

--2
length :: [a] -> Integer
length [] = 0
length (h:t) = 1 + length t

reverse :: [a] -> [a]
reverse [] = []
reverse (h:t) = reverse t ++ [t]

--3
catMaybes :: [Maybe a] -> [a]
catMaybes [] = []
catMaybes (Nothing:t) = catMaybes t
catMaybes (Maybe h: t) = h: catMaybes t

--4
uncurry :: (a -> b -> c) -> (a, b) -> c
uncurry f (x, y) = f x y

curry :: ((a, b) -> c) -> a -> b -> c
curry f x y = f (x,y)

flip :: (a -> b -> c) -> b -> a -> c
flip f x y = f y x

--5
data LTree a = Leaf a | Fork (LTree a, LTree a)

flatten :: LTree a -> [a]
flatten Leaf x = [x]
flatten Fork (x, y) = flatten x ++ flatten y

mirror :: LTree a -> LTree a
mirror Leaf x = Leaf x
mirro Fork (x, y) = Fork (mirror y, mirror x)

fmap :: (b -> a) -> LTree b -> LTree a
fmap f Leaf x = Leaf f x
fmap f Fork(x, y) = Fork( fmap f x, fmap f y)

--6
length :: [a] -> Integer
length = foldr (\_ n -> n + 1) 0

--7
concat :: [[a]] -> [a]
concat [] = []
concat (h:t) = h ++ concat t

--8
-- Se o valor for superior a 0 é incrementado, senão é eliminado
f :: [Integer] -> [Integer]
f = foldr (\x xs-> if x > 0 then (x+1):xs else xs) []

--9a
m :: (a -> b) -> [a] -> [b]
m = foldr (\ x y -> f x : y) []

--9b :thinking:
m :: (a -> b) -> [a] -> [b]
m = map

--9c
-- m :: [a] -> [[a]]