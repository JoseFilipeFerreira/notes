# Índice
* [Utilitários](#Utilitários)
* [Mínimos Quadrados](#Mínimos-Quadrados)
    * [Polinómios Ortogonais](#Polinómios-Ortogonais)
    * [Modelo não polinomial linear](#Modelo-não-polinomial-linear)
* [Quasi-Newton](#Quasi-Newton)
    * [Sem derivadas](#Sem-derivadas)
    * [Com derivadas](#Com-derivadas)
* [Método de Nelder-Head](#Método-de-Nelder-Head)

- - - -

# Utilitários
> Alterar a precisão
```matlab
format long  % 15 casas decimais
format short %  5 casas decimais
```

- - - -

# Mínimos Quadrados
## Polinómios Ortogonais
```matlab
x = [1.5 2 3 4]
y = [4.9 3.3 2 1.5]

[p,s] = polyfit(x,y,1)

polyval(p,2.5)

%Residuo do erro
(s.normr)^2
```

## Modelo não polinomial linear
```matlab
x = [1.5 2 3 4]
y = [4.9 3.3 2 1.5]

foo = @(c,x) c(1)./x + c(2).*x
[c,resnorm,residual,exitflag,out] = lsqcurvefit(foo,[1 1],x,y)

%Residuo do erro
resnorm
```

- - - -

# Quasi-Newton
> Se for para saber o max (este método so calcula min) portanto `max = -min(-f(x))`

## Sem derivadas
```matlab
foo = @(x) 0.25*x(1)^4-0.5*x(1)^2+0.1*x(1)+0.5*x(2)^2
fminunc(foo)
% OU
[x,y,ef,out] = fminunc(@(x) 0.25*x(1)^4-0.5*x(1)^2+0.1*x(1)+0.5*x(2)^2,[-1 0.5])
```

> Se `ef < 0` não converge

> Se `ef = 0` atinge nº max iterações -> aumentar maxIter

> Se `ef > 0` converge

## Com derivadas
```matlab
function [f,g] = foo(x)
    f = 0.25*x(1)^4-0.5*x(1)^2+0.1*x(1)+0.5*x(2)^2;
    g(1) = x(1)^3%derivada em x1
    g(2) = x(2)%derivada em x2
end

op = optimset('gradobj','on')
[x,y,ef,out] = fminunc('foo',[-1 0.5],op)

```

### optimset options:
* 'tolfun',10
* 'tolx',10
* 'HessUpdate','DFP'
* 'MaxIter',10000
* 'MaxFunEvals',10000

- - - -

# Método de Nelder-Head
```matlab
foo = @(x) max(abs(x(1)),abs(x(2)-1))

op = optimset('display','iter')

[x,y,ef,out] = fminsearch(foo,[1 1],op)
```
