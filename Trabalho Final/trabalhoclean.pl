/* Parte Funcional */

codifica_rec(_,[],[]).  %recursao final onde a lista de palavras = vazia, pois já codificamos todas as letras para codigos
codifica_rec([(A,B) | Xs], [H|T], [C1 |Rc]) :-
    codifica_1letra([(A,B) | Xs], H, C1),
    codifica_rec([(A,B) | Xs], T, Rc).

codifica_1letra([(L,C) | R], L ,C)  :- !.
codifica_1letra([_|R], L, C) :- codifica_1letra(R,L,C).


descodifica_rec(_,[], []).  %recursao final onde a lista de palavras = vazia, pois já codificamos todos os codigos para letras
descodifica_rec([(A,B) | Xs], [H|T], [C1 |Rc]) :-
    descodifica_1letra([(A,B) | Xs], H, C1),
    descodifica_rec([(A,B) | Xs], T,Rc).

descodifica_1letra([(L,C) | R], C, L) :- !.
descodifica_1letra([_|R], C,L) :- descodifica_1letra(R,C,L).

/*gera_palavras_tamanho([X|Xs], L, Y) :-
    gera_palavras([X|Xs],Y),
    tamanho_lista(Y,R),
    R =< L.
    
gera_palavras([H|_], [H]).

gera_palavras([_|T], C) :-   % Combinations of the tail w/o head
   gera_palavras(T, C).

gera_palavras([H|T], [H|C]) :-  % Combinations of the tail including head
   gera_palavras(T, C).*/
%------------------------------------------%
/*wordlist(N, L) :-
    wordlist(N, [], L, []).

wordlist(0, R, [W|T], T) :-
    rev(R, W),
    !.
wordlist(N, C, L, T) :-
    N > 0,
    N1 is N-1,
    wordfold([a,b,c], N1, C, L, T).

wordfold([], _, _, L, L).
wordfold([C|CS], N1, CT, L, T) :-
    wordlist(N1, [C|CT], L, L2),
    wordfold(CS, N1, CT, L2, T).*/

word(L,0, []).
word(L,N,[C|W]) :-   
    N > 0,
    N1 is N-1,
    member(C,L),
    word(L,N1, W).
    
%letter(X,Y) :- member(X, Y).   %em backtrack member faz a; b;c

gera_palavras(L,N,M,[]).
gera_palavras(L,N, M,[C|W]) :-   %N deve ser limite minimo e M limite maximo
    N =< M,
    N1 is N+1,
    member(C,L),
    gera_palavras(L,N1,M, W).    %chamada recursiva

%Predicado que retorna a lista de letras existentes no dicionário pretendido
%Irá ser usado para gerar todas as palavras comas respeticas letras
%Exemplo 1 do enunciado vai retornar -> X = [a,c,j,l,p,s,v]
%Exemplo 2 do enunciado vai retornar -> X = [a,b,c,f,j,l,r]
prefixo([],[]).
prefixo([(X,_)|T], [X|T2]):- prefixo(T,T2).

%Facto Dicionário atribui ao valor X a lista que contém todos os códigos na lista Y
dicionario(X,Y).


get_palavras_todas(L,N,M,X,Y) :- findall(X,gera_palavras(L,N,M,X),Y).
    /*gera_palavras(L,N,M,X), 
    codifica_rec(L,X,Y).*/

%codificação_palavras(L,N,M,X) :- gera_palavras(L,N,M,X).
ambiguo(L,P,P1,P2,P3) :-
    prefixo(L,P),
    gera_palavras(P,1,7,P1),
    codifica_rec(L,P1,P2),
    descodifica_rec(L,P2,P3),
    P1 \= P3.  % The reading in classical logic (or even constructive logic?) would be "in any solution, P1 and P3 must be different!"



%gera palavras menor que x, mesmos argumentos + mais nunero maximo de letras, chamamos gera palavras, e depois ver se a lista é menor que esse numero ou nao
%tentar gerar por tamanho
%gera_palavras([a,b],X)

% exemplo 1 do enunciado [(a, [0,1,0]),(c, [0,1]),(j, [0,0,1]),(l, [1,0]),(p, [0]),(s, [1]),(v, [1,0,1])]
% exempo 2 do enunciado [(a, [0,1,1,0]),(b, [0,1,1,1,1,1]),(c, [1,1,0,0,1,1,1,1]),(f, [1,0,1,1,1,0]),(j, [0,1,0]),(l, [0,1,0,0]),(r, [0,1,1,1,0])]
%gera_palavras([(a, [0,1,0]),(c, [0,1]),(j, [0,0,1]),(l, [1,0]),(p, [0]),(s, [1]),(v, [1,0,1])],X,Y).
%gera_palavras([a,b,c],X), codifica_rec([(a, [0,1,0]),(c, [0,1])],X,Y).
%gera_palavras([(a, [0,1,0]),(c, [0,1])],X,Y).
%findall(X, gera_palavras_tamanho([a,b,c,d],3, X), L).  

%dicionario(DIC), !, words(DIC, 7, 1, W), encode_word(DIC, W, C), decode_word(DIC, C, W2), W \= W2.