match([H|_],0,H) :-
    !.
match([_|T],N,H) :-
    N > 0, %add for loop prevention  
    N1 is N-1, %The base case is thus that the index is 0 in which case you return the head, otherwise you query for the i-1-th element of the tail. This is also a more declarative approach.
    match(T,N1,H).


indexOf([Element|_], Element, 0). % We found the element
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1), % Check in the tail of the list
  Index is Index1+1.  % and increment the resulting index

indices(List, E, Is) :-
    findall(N, nth1(N, List, E), Is).


/* PartE Funcional */

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


gera_palavras([(A,B) | Xs], [H|T], [R|Q]) :- 
    codifica_rec([(A,B) | Xs], [H|T], [R|Q]).

%findall(S, timetable(S), AllSolutions).


% exemplo 1 do enunciado [(a, [0,1,0]),(c, [0,1]),(j, [0,0,1]),(l, [1,0]),(p, [0]),(s, [1]),(v, [1,0,1])]
% exempo 2 do enunciado [(a, [0,1,1,0]),(b, [0,1,1,1,1,1]),(c, [1,1,0,0,1,1,1,1]),(f, [1,0,1,1,1,0]),(j, [0,1,0]),(l, [0,1,0,0]),(r, [0,1,1,1,0])]
%gera_palavras([(a, [0,1,0]),(c, [0,1]),(j, [0,0,1]),(l, [1,0]),(p, [0]),(s, [1]),(v, [1,0,1])],X,Y).
%gera_palavras([(a, [0,1,0]),(c, [0,1])],X,Y).