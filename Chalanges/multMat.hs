transpose :: [[a]] -> [[a]]
transpose = foldr (zipWith (:)) (repeat [])

multSumVec :: Num a => [a] -> [a] -> a
multSumVec = (sum .) . zipWith (*)

multMat :: Num a => [[a]] -> [[a]] -> [[a]]
multMat ml mr = map (\x -> map (multSumVec x) (transpose mr)) mr
