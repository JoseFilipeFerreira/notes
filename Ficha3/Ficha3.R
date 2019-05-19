#2
nul6 <- matrix(data = 0, nrow = 6, ncol = 6)
C <- abs(col(nul6) - row(nul6))
C[C!=1]<-0
m <- C
M <- m
diag(M) <- 1:6

#3
A <- outer(0:4, 0:4, "+")
B <- outer(1:4, 0:4, "*")

#Lançar um dado
#Obtenha estimativas para a probabilidade do número de ases em 5 lançamentos consecutivos seja menor do que 3
dado <- sample(1:6, 5, replace = T)

#6
x <- sample(1:10, 5)
y <- sample(1:11, 6)

f3 <- function(x, y){
n <- length(x)
z <- numeric(n)
for (k in 1:n){z[k]<- sum(y<x[k])}
z
}




