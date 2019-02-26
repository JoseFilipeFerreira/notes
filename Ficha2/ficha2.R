#1
fun1 <- function(x){
len<-length(x)
x^(1:len)
}

fun2 <- function(x){
len<-length(x)
x^(1:len)/(1:len)
}

#2a
f<-function(x, y){
(y - c(1,x))[-1]
}

#2b
f<-function(x, y){
(exp(c(1,y)) * cos(x))[-1]
}