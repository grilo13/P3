%%%Predicado que faz a codificação recursiva de uma palavra
codifica_rec(_,[],[]).  %recursao final onde a lista de palavras = vazia, pois já codificamos todas as letras para codigos
codifica_rec([(A,B) | Xs], [H|T], [C1 |Rc]) :-
    codifica_1letra([(A,B) | Xs], H, C1),
    codifica_rec([(A,B) | Xs], T, Rc).

codifica_1letra([(L,C) | R], L ,C)  :- !.
codifica_1letra([_|R], L, C) :- codifica_1letra(R,L,C).

%%% Predicado que faz a descodificação recursiva de um código
descodifica_rec(_,[],[]).
descodifica_rec([(A,B) | Xs], L, [C1 |Rc]) :-
    append(X,Y,L),  %L = lista, Y =  resto, X = valor a codificar primeiro
    descodifica_1codigo([(A,B) | Xs],X,C1),
    descodifica_rec([(A,B) | Xs], Y, Rc).

descodifica_1codigo([(L,C) | R], C, L) :- !.
descodifica_1codigo([_|R], C,L) :- descodifica_1codigo(R,C,L).

list_length(Xs,L) :- list_length(Xs,0,L) .

list_length( []     , L , L ) .
list_length( [_|Xs] , T , L ) :-
  T1 is T+1 ,
  list_length(Xs,T1,L)
  .
    
%%% Predicado que gera todas as palavras entre um indice minimo N e um indice maximo M (inclusive)
gera_palavras(L,N,M,[]).
gera_palavras(L,N, M,[C|W]) :-   %N deve ser limite minimo e M limite maximo
    N =< M,
    N1 is N+1,
    member(C,L),
    gera_palavras(L,N1,M, W).    %chamada recursiva

gera_palavras1(L,X,C) :- 
    gera_palavras(L,X,X,C).

gerar_palavras_ordem(L,N,M,[]).
gerar_palavras_ordem(L,N,M,[C|C1]) :-
    N =< M,
    findall(X,gerar_palavra_fixed(L,N,X),Y),
    N1 is N+1,
    append(Y,[],C),
    gerar_palavras_ordem(L,N1,M,C1).

gerar_palavras_final(L,N,M,[]).
gerar_palavras_final(L,N,M,[C|T]) :- %S representa os nº de indices entre N e M, ou seja, se N=1 e M=3, então vai retornar 3 (1->2->3)
    N =< M,
    N1 is N+1,
    findall(X,gerar_palavra_fixed(L,N,X),Y),
    append(Y,[],C),
    gerar_palavras_final(L,N1,M,T).

gerar_size(L,N,M,Y) :-
    gerar_palavras_final(L,N,M,X),      %predicado que retorna em backtrack uma lista com o findall de todos os elementos possiveis na geração de palavras
    length(X,P1),      %tamanho das listas que vêm em backtrack
    my_flatten(X,Y),   %vai juntar as listas que vêm do backtrack x -> retorna findall de todas as iterações das gerações
    P1 = M.            %de palavras

gera_backtrack(L,N,M,Y) :-
    gerar_size(L,N,M,X),
    member(Y,X).

my_flatten([], []).
my_flatten([A|B],L) :- is_list(A), my_flatten(B,B1), !, append(A,B1,L).
my_flatten([A|B],[A|B1]) :- my_flatten(B,B1).

gerar_palavra_fixed(L,0, []).
gerar_palavra_fixed(L,N, [C|W]) :-
    N > 0,
    N1 is N-1,
    member(C,L),
    gerar_palavra_fixed(L,N1, W).

%%% Predicado que recebe uma lista e retorna essa lista em backtracking
member2(X, [X|_]).
member2(X, [_|Y]) :- member2(X,Y).

%%% Predicado que recebe a lista com todas as palavras (não por ordem de tamanho), e usa o bubblesort 
%%% para fazer uma lista com as listas em tamanho crescente, e as retorna em backtracking com o predicado member
auxiliar(P,N,M,Z) :- 
    findall(X,gera_palavras(P,N,M,X),Y),
    bubblesort(Y,L),
    member(Z,A).

take(L, N, L1) :- 
    length(L1, N), 
    append(L1, _, L).

%%% Predicado que retorna a lista de letras existentes no dicionário pretendido
%%% Irá ser usado para gerar todas as palavras comas respeticas letras
%%% Exemplo 1 do enunciado vai retornar -> X = [a,c,j,l,p,s,v] // Exemplo 2 do enunciado vai retornar -> X = [a,b,c,f,j,l,r]
prefixo([],[]).
prefixo([(X,_)|T], [X|T2]):- prefixo(T,T2).

%%% Predicado que concatena listas, que por sua vez estejam dentro de uma lista
%%% Exemplo -> [[0,1,0],[1,1]] = [0,1,0,1,1]
juntar_listas([], []) :- !.
juntar_listas([L|Ls], FlatL) :-
    !,
    juntar_listas(L, NewL),
    juntar_listas(Ls, NewLs),
    append(NewL, NewLs, FlatL).
juntar_listas(L, [L]).

%%% Predicado bubblesort que tem recebe uma lista não ordenada de forma crescente do seu tamanho,
%%% e retorna a mesma lista de listas com a ordem correta
bubblesort(List, SortedList) :-
    swap(List, List1), ! ,
    bubblesort(List1,SortedList).
bubblesort(List, List).
   
swap([A,B|Rest],[B,A|Rest]):-
    length(A,A_len),length(B, B_LEN),A_len @> B_LEN,!.
swap([Z|Rest],[Z|Rest1]):-
    swap(Rest,Rest1).

%findall(X, gera_palavras([a,c],1,3,X),Y), bubblesortt(Y,D).

%%% Predicado ambiguo = recebe como output o dicionário, e retorna o código ambiguo (P3), e as duas palavras que o codificam (P1 e P4)
ambiguo(L,P4,P3,P1) :-
    prefixo(L,P),    %retorna uma lista com as letras todas do dicionario [a,c,j,l,p,s,v]
    %gera_palavras(P,1,3,P1), 
    %auxiliar(P,1,3,P1),   %gera todas as palavras com as letras dadas, entre um tamanho dado
    gera_backtrack(P,1,4,P1),
    codifica_rec(L,P1,P2),
    juntar_listas(P2,P3),   %p3 mostra os valores de uma palavra codifica apenas numa lista [[0,1,0],[0,1,0]]  = [0,1,0,0,1,0] 
    length(P3,P5),     
    descodifica_rec(L,P3,P4),  
    P1 \= P4. % P1 e P4 têm de ser diferentes -> a palavra codifica inicialmente, tem um código que pode ser igual para outra palavra também
    %!.

%Exemplo 1 do enunciado
%ambiguo([(a, [0,1,0]),(c, [0,1]),(j, [0,0,1]),(l, [1,0]),(p, [0]),(s, [1]),(v, [1,0,1])], M, T1, T2)

%Exemplo2 do enunciado
%ambiguo([(a, [0,1,1,0]),(b, [0,1,1,1,1,1]),(c, [1,1,0,0,1,1,1,1]),(f, [1,0,1,1,1,0]),(j, [0,1,0]),(l, [0,1,0,0]),(r, [0,1,1,1,0])], M, T1, T2)