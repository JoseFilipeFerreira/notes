# Índice

* [Funções](#Funções)
* [Definir Funções](#Definir-Funções)
* [Resolver sistemas de equações](#Resolver-sistemas-de-equações)
* [Resolver equação](#Resolver-equação)
* [Estimar valores](#Estimar-valores)
  * [Polinómio Interpolador de Newton](#Polinómio-Interpolador-de-Newton)
  * [Spline](#Spline)
    * [Spline Cúbica](#Spline-Cúbica)
    * [Spline Cúbica Completa](#Spline-Cúbica-Completa)
    * [Segmento de Spline](#Segmento-de-Spline)
* [Valor do Integral](#Valor-de-Integral)
  * [Função](#Função)
  * [Valores](#Valores)

- - - -

# Funções
* ones(n) -> matriz de 1s tamanho nxn
* zeros(n) -> matriz nula de ordem n
* eye(n) -> matriz identidade de ordem n
* ()’ -> transposta da matriz
* det () -> determinante da matriz
* rank() -> característica da matriz
* inv() -> inversa da matriz
* diag()-> diagonal da matriz
* triu(), tril() -> matriz triangular superior/inferior da matriz
* norm(,1), norm(,inf)-> normas (1 e inf) da matriz
* A \ b -> resolução do sistema linear

```
>> b=[1; 3; -6]
>> A=[1 -3 4; 2 5 -2; 3 8 10]
>> A\b %sistema linear Ax=b
ans =
2.2703
-0.6216
-0.7838
>> norm(A,1) %norm
```

- - - -

# Definir Funções
```Matlab
function [output] = function_name(input)
output = operation_on_input
```
NOTA: definir na Function Window

## Exemplos
* definir uma função "normal"
```Matlab
function [f] = fun1(x)
f = x^2 + x +1
```
* definir um sistema de equações
```Matlab
function [f] = fun2(x)
f(1) = x
f(2) = x^2
```

NOTA: é possível definir lambdas com `@(x) operation_on_x`

- - - -

# Resolver sistemas de equações
* definir a função
* utilizar o comando **fsolve**
```Matlab
op = optimset('tolfun',TolFun_Value,'tolx',TolX_Value);
x1 = Aproximação_inicial;
format long;
[x,fval,exitflag, output] = fsolve('fun2', x1, op)
```
NOTA: tolx -> critério de paragem

- - - -

# Resolver equação
* definir a função
* utilizar o comando **fsolve**
```Matlab
op = optimset('tolx',TolX_Value);
x1 = Aproximação_inicial;
format long;
[x,fval,exitflag, output] = fsolve('fun2', x1, op)
```
- - - -

# Estimar valores
## Polinómio Interpolador de Newton
* obter os grau + 1 pontos em torno do ponto x (por proximidade)
* calcular o polinómio interpolador
```Matlab
pol = polyfit(points_X, points_Y, grau);
```
* calcular um ponto nesse polinómio
```Matlab
format long;
polyval(pol, point_X)
```

## Spline
### Spline Cúbica
```Matlab
sp = spline(points_X, points_Y, x)
```

### Spline Cúbica Completa
```Matlab
sp = spline(points_X, [declive_inferior points_Y declive_superior], x)
```

NOTAS(apenas utilizar se for explicitado que é necessário):
* se tiver função e não tiver declives
  * derivar função
  * calcular declive para pontos
* se não tiver função nem declives
  * calcular declive dos primeiros dois e últimos dois
  * remover o segundo ponto e último ponto dos vetores

### Segmento de Spline
```Matlab
sp = spline(points_X, points_Y)
% OU
sp = spline(points_X, [declive_inferior points_Y declive_superior])
sp.coefs
```

- - - -

# Valor do Integral

## Função
```matlab
quad(fun,a,b)
quadl(fun,a,b)
quad(fun,a,b,error)
```
NOTA:
* fazer `[z, nf] = quad(@(x) x+1 , 1, 2, 0.00001)`
  * z -> result
  * nf -> número de avaliações da função

## Valores
```matlab
trapz(points_X, points_Y)
```

- - - -

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
