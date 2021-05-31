:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- dynamic '-'/1.
:- dynamic mamifero/1.
:- dynamic morcego/1.

:- op( 1100,xfy,'??' ).

si( Questao,verdadeiro ) :-
    Questao.
si( Questao,falso ) :-
    -Questao.
si( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).

Questao ?? verdadeiro :-
    Questao.
Questao ?? falso :-
    -Questao.
Questao ?? desconhecido :-
    nao( Questao ),
    nao( -Questao ).

voa( X ) :- ave( X ),nao( excecao( voa( X ) ) ).
-voa( X ) :- mamifero( X ),nao( excecao( -voa( X ) ) ).
-voa( X ) :- excecao( voa( X ) ).
voa( X ) :- excecao( -voa( X ) ).

-voa( tweety ).

nao(Questao) :- Questao, !, fail.
nao(_).

excecao( voa( X ) ) :- avestruz( X ).
excecao( voa( X ) ) :- pinguim( X ).
excecao( -voa( X ) ) :- morcego( X ).

ave( pitigui ).
ave( X ) :- canario( X ).
ave( X ) :- periquito( X ).
ave( X ) :- avestruz( X ).
ave( X ) :- pinguim( X ).

canario( piupiu ).
avestruz( trux ).
pinguim( pingu ).

mamifero(silvestre).
mamifero(X) :- cao(X).
mamifero(X) :- gato(X).
mamifero( X ) :- morcego( X ).

morcego(batemene).
cao(boby).
