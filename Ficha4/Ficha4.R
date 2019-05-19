?iris
iris

attach(iris)

species[Petal.Length==max(Petal.Length)]

mean(Petal.Length[Species=="viginia"])

tapply(Petal.Length, Species, mean)
