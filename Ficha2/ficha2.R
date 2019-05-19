#fatorial
f<-function(n){
    if(n<0) stop("N não pode ser negativo")
    if(n==0) 1
    else n + f(n-1)
}

#fibonaci
f<-function(n){
    if(n<=0) stop("N não pode ser negativo")
    if (n<=2) 1
    else f(n-1) + f(n-2)
}

#scope examples
function(){
if(!exists("a"))a<-1
else a<-a+1
a
}

#1
fun1 <- function(x){
len<-length(x)
x^(1:len)
}

fun2 <- function(x){
len<-length(x)
x^(1:len)/(1:len)
}

plot(-4:1, fun1(-4:1), xlab="x", ylab="fun1", type="o")
lines(-4:1, fun2(-4:1), type="o", col="blue", lty=2)

#2a
f<-function(x, y){
(y - c(1,x))[-1]
}

#2b
f<-function(x, y){
(exp(c(1,y)) * cos(x))[-1]
}

#4
divisores<-function(n){
    if(n<=0 | n%%1 !=0) stop(n, "Não é um número natural")
    else{
        d<-1:n
        div<-d[n%%d==0]
        div
    }
}

num<-readline(prompt="Introduza um número natural\n")
num<-as.integer(num)
divisores(num)


primo<-function(n){
    if(n<=0 | n%%1 !=0) -1
    else{
        if(length(divisores(n)) ==2)
            cat(n, "é primo\n")
        else cat(n, "não é primo\n")
    }
}

is_primo<-function(n){
    if(n<=0 | n%%1 !=0) -1
    else{
        if(length(divisores(n)) ==2)
            1
        else 0
    }
}

map_f<-function(x, fun){
    out<-c()
    for(i in seq_along(x)){
        out[i] <- fun(x[i])
    }
    out
}

prop.table(table(map_f(2:2300, is_primo)))

f<-function(x){(x^2) * cos(x)}

curve(f(x), from = -2*pi, to = 2*pi, n = 30)

#6
f<-function(x) ifelse(x>=0, x^2, -x)

plot(seq(-2,2,0.01), f(seq(-2,2,0.01)), type="l")
lines( c(-2,2), c(2,4) )

#8

ols<-function(x, y){
    if(sum(is.na(x))>0 | sum(is.na(y))>0) stop("os dados têm NA's")
    else{
        if(length(x) != length(y)) stop("os vetores não têm o mesmo comprimento")
        else{
            mx<-mean(x)
            my<-mean(y)
            b_num<-sum((x-mx)*(y-my))
            b_den<-sum((x-mx)^2)
            b<-b_num/b_den
            a<-my-b*mx

        }
    
    }
    cat("os valores de a e b são ", c(a,b))
}

ols(c(38, 56, 59, 64, 74), c(41, 63, 70, 72, 84))




