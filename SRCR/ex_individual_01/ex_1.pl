% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- dynamic '-'/1.
:- op( 900,xfy,'::' ).

:- dynamic pais/3.
%pais(filho, pai, mae).

:- dynamic nasceu/4.
%nasceu(pessoa, dia, mes, ano).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do meta-predicado demo: Questão,Resposta -> {V,F}
demo( Q, verdadeiro ) :- Q.
demo( Q, falso ) :- -Q.
demo( Q, desconhecido ) :- nao( Q ), nao( -Q ).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do meta-predicado nao: Questão -> {V,F}
nao( Q ) :- Q, !, false.
nao( Q ).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

% i.
pais(ana, abel, alice).
nasceu(ana, 01, 01, 2010).

% ii.
pais(anibal, antonio, alberta).
nasceu(anibal, 02, 01, 2010).

% iii.
pais(berta, bras, belem).
pais(berto, bras, belem).
nasceu(berta, 02, 02, 2010).
nasceu(berto, 02, 02, 2010).

% iv.
nasceu(catia, 03, 03, 2010).

% v.
excecao(pais(crispim, celso, catia)).
excecao(pais(crispim, caio, catia)).

% vi.
excecao(pais(danilo, daniel, desconhecida6)).
nuloImpreciso(desconhecida6).
nasceu(danilo, 04, 04, 2010).

% vii.
pais(eurico, elias, elsa).
excecao(nasceu(eurico, 5, 05, 2010)).
excecao(nasceu(eurico, 15, 05, 2010)).
excecao(nasceu(eurico, 25, 05, 2010)).

% viii. 
excecao(pais(fabia, fausto, desconhecida8)).
excecao(pais(octavia, fausto, desconhecida8)).
nuloImpreciso(desconhecida8).

% ix.
pais(golias, guido, guida).
nasceu(golias, dia_desconhecido, mes_desconhecido, ano_desconhecido).
nuloIncerto(dia_desconhecido).
nuloIncerto(mes_desconhecido).
nuloIncerto(ano_desconhecido).

% x.
-nasceu(helder, 08, 08, 2010).

% xi.
excecao(nasceu(ivo, D, 06, 2010)) :- D > 0, D < 16.
