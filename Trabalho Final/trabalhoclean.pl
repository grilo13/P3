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


/*gera_palavras(InList,X) :-
    splitSet(InList,_,SubList),
    SubList = [_|_],     
    permute(SubList,X).

splitSet([ ],[ ],[ ]).
splitSet([H|T],[H|L],R) :-
    splitSet(T,L,R).
splitSet([H|T],L,[H|R]) :-
    splitSet(T,L,R).

permute([ ],[ ]) :- !.
permute(L,[X|R]) :-
    omit(X,L,M),
    permute(M,R).

omit(H,[H|T],T).
omit(X,[H|L],[H|R]) :-
    omit(X,L,R). */

tamanho_lista(Xs,L) :- tamanho_lista(Xs,0,L) .
tamanho_lista( []     , L , L ) .
tamanho_lista( [_|Xs] , T , L ) :-
  T1 is T+1 ,
  tamanho_lista(Xs,T1,L).

gera_palavras_tamanho([X|Xs], L, Y) :-
    gera_palavras([X|Xs],Y),
    tamanho_lista(Y,R),
    R =< L.
    
gera_palavras([H|_], [H]).

gera_palavras([_|T], C) :-   % Combinations of the tail w/o head
   gera_palavras(T, C).

gera_palavras([H|T], [H|C]) :-  % Combinations of the tail including head
   gera_palavras(T, C).

%-----------------------------------------%
rev(L, R) :- rev(L, [], R).
rev([], R, R).
rev([A|B], X, R) :- rev(B, [A|X], R).
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
letter(X) :- member(X, [a, b, c]).

word(0, []).
word(N,[C|W]) :-   %M deve ser limite minimo e N limite maximo
    N > 0,
    N1 is N-1,
    letter(C),
    word(N1, W).




%gera palavras menor que x, mesmos argumentos + mais nunero maximo de letras, chamamos gera palavras, e depois ver se a lista é menor que esse numero ou nao
%tentar gerar por tamanho
%gera_palavras([a,b],X)

% exemplo 1 do enunciado [(a, [0,1,0]),(c, [0,1]),(j, [0,0,1]),(l, [1,0]),(p, [0]),(s, [1]),(v, [1,0,1])]
% exempo 2 do enunciado [(a, [0,1,1,0]),(b, [0,1,1,1,1,1]),(c, [1,1,0,0,1,1,1,1]),(f, [1,0,1,1,1,0]),(j, [0,1,0]),(l, [0,1,0,0]),(r, [0,1,1,1,0])]
%gera_palavras([(a, [0,1,0]),(c, [0,1]),(j, [0,0,1]),(l, [1,0]),(p, [0]),(s, [1]),(v, [1,0,1])],X,Y).
%gera_palavras([a,b,c],X), codifica_rec([(a, [0,1,0]),(c, [0,1])],X,Y).
%gera_palavras([(a, [0,1,0]),(c, [0,1])],X,Y).
%findall(X, gera_palavras_tamanho([a,b,c,d],3, X), L).  