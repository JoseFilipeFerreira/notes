# Teste 2015/2016

## EX1

**Function Window**
```Matlab
function [f] = funEX1TESTETIPO(x)
f(1)= -5x(1) + 3sin(x(1)) + cos(x(2));
f(2)= 4cos(x(1)) + 2sin(x(2)) - 5*x(2);
```

**Command Window**
```Matlab
op = optimset('tolfun',0.1,'tolx',0.01);
x1 = [0 0.1];
format long;
[x,fval,exitflag, output] = fsolve('funEX1TESTETIPO', x1, op)
```

**Result**
```Matlab
x1 = 0.202868440507818
x2 = 1.149731058980664

fval =  -0.001169979890327  -0.005376496458623

exitflag =  1
iterations: 2
        funcCount: 9
        algorithm: 'trust-region-dogleg'
    firstorderopt: 0.023555167275796
          message: 'Equation solved.↵↵fsolve completed because the vector of function values is near zero↵'''
```

## EX2

**Function Window**
```Matlab
function [f] = funEX2TESTETIPO(x)
f = ((1-((1+x)^(-12))) / x) - ((315-91)/24);
```

**Command Window**
```Matlab
op2 = optimset('tolx',0.1);
[x,fval,exitflag, output] = fsolve('funEX2TESTETIPO', 0.04, op2)
```

**Result**
```Matlab
x =   0.040954076659222
fval =  3.565524764326256e-09

exitflag =     1
output =
  struct with fields:
       iterations: 2
        funcCount: 6
algorithm: 'trust-region-dogleg'
    firstorderopt: 1.925665159690314e-07
message: 'Equation solved.↵↵fsolve completed because the vector of function values is near zero↵as measured by the default value of the function tolerance, and↵the problem appears regular as measured by the gradient.'
```

## EX3

### a) b)
**Command Window**
```Matlab
xi = [1.5 2.0 2.2 3.0 3.8 4.0];
f_xi = [4.9 3.3 3.0 2.0 1.75 1.5];
p2 = polyfit(xi(2:4),f_xi(2:4),2);
format long;
polyval(p2,2.8)
```

**Result**
```Matlab
a) polival = 2.220000000000001

b) p2 =   0.249999999999990  -2.549999999999950   7.399999999999936

=> (0.249999999999990 ) * x^2 + (-2.549999999999950  ) * x + (7.399999999999936)
```

### c) d)

**Command Window**
```Matlab
s3 = spline(xi, [-2 f_xi 3]);
s3.coefs
```

**Result**
```Matlab
8.631332599118954  -6.715666299559479  -2.000000000000000   4.900000000000000
 -12.602491740088112   6.231332599118951  -2.242166850220264   3.300000000000000
   1.681348086453748  -1.330162444933926  -1.261932819383257   3.000000000000000
  -3.616490569933921   2.705072962555068  -0.162004405286345   2.000000000000000
  68.061261013215741  -5.974504405286346  -2.777549559471363   1.750000000000000
```

x = 2.5 => terceiro segmento (i=3)  (linha 3 do coefs)
xi = 2.2 (ponto inicial do segmento 3)
Logo,

d)
```Matlab
s3(i=3; X) = (1.681348086453748 * (X - 2.2)^3) + (-1.330162444933926 * (X - 2.2)^2) + ( -1.261932819383257 * (X - 2.2)) + (3.000000000000000)
```
c)
```Matlab
spline(xi, [-2 f_xi 3], 2.5) = 2.547101932475221
```
OU

```Matlab
s3(i=3; X=2.5)

=  (1.681348086453748 * (2.5 - 2.2)^3) + (-1.330162444933926 * (2.5 - 2.2)^2) + ( -1.261932819383257 * (2.5 - 2.2)) + (3.000000000000000)

= 2.547101932475221
```

## EX4

**Command Window**
```Matlab
t = [0 10 15 25 30 48 60 70 90];
v = [0 10 30 25 10 28 40 42 30];
trapz(t,v)
```

**Result**
```Matlab
comprimento = 2.392500000000000e+03
```
## EX5

**Command Window**
```Matlab
quadl('x.*(1-exp(-x))+x.^3',0,10)
quad('x.*(1-exp(-x))+x.^3',0,10)
```

**Result**
```Matlab
quadl = 2.549000499399404e+03
quad = 2.549000499438770e+03
```
