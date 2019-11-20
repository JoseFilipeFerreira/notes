transpose :: [[a]] -> [[a]]
transpose ([]:_) = []
transpose l = (map head l) : transpose (map tail l)

multSumVec :: Num a => [a] -> [a] -> a
multSumVec = (sum .) . zipWith (*)

multMat :: Num a => [[a]] -> [[a]] -> [[a]]
multMat ml mr = map (\x -> map (multSumVec x) (transpose mr)) mr
