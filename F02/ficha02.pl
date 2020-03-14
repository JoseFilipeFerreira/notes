% 1
soma(X,Y,R) :- R is X+Y.

%2
soma(X,Y,Z,R) :- R is X+Y+Z.

%3
soma([], 0).
soma([H|T], R) :- soma(T,N), R is H+N.

%4
calc(X,Y,SUM, SUB, MUL, DIV) :- SUM is X+Y, SUB is X-Y, MUL is X*Y, DIV is X/Y.

%5
calc([], 'MUL', 1).
calc([], 'SUM', 0).

calc([H|T], 'MUL', R) :- calc(T, 'MUL', N), R is H*N.
calc([H|T], 'SUM', R) :- calc(T, 'SUM', N), R is H+N.

%6
maxi(X,Y,M) :- M is max(X,Y).

%7
maxi(X,Y,Z,M) :- M is max(max(X,Y), Z).

%8
maxi([H], M) :- M is H.
maxi([H|T], M) :- maxi(T,TM), M is max(H, TM).

%9
mini(X,Y,M) :- M is min(X,Y).

%10
mini(X,Y,Z,M) :- M is min(min(X,Y),Z).

%11
mini([H], M) :- M is H.
mini([H|T], M) :- mini(T,TM), M is min(H, TM).

%12
avg(L, A) :- calc(L, 'SUM', R), length(L,S), A is R/S.

%13
sortList([], []).
sortList(L, S) :- mini(L, M), delete(M, L, R), sortList(R, ST), S is [M | ST].





