%#append([], X,X).
%#append([X | Y], Z , [X | W]) :- append(Y,Z,W).

%codifica([],X,X).  
%codifica([(A,B)| Xs], L, [(A,B) | Y]) :-       %first argument is a list where [(A,B) | XS] the head is a tuple with (A,B) and the second one is list, third is also a list
%    codifica(Xs, L, Y).

%codifica([(A, B)| Xs], L, [(A,B) | Y]) :- 

%notrace

/*codifica(A,[A]).
codifica((A,B), L ,P) :-
    !,W
    codifica(A, L0),
    codifica(B, L1),
    append(L0,[],L),
    append(L1,[],P).

member(El, [H|T]) :- member_(T, El, H).

member_(_, El, El).
member_([H|T], El, _) :- member_(T, El, H).*/
%codifica1(L, X, Y) :- codifica1(L,X,Y).

/*codifica([(A,B) | Xs], [H | T], X) :-
    */

%extract_second_item([], []).
%extract_second_item([(_,X)|T], [X|T2]):- extract_second_item(T,T2).

sufixo([],[]).
sufixo([(_,X)|T], [X|T2]):- sufixo(T,T2).

prefixo([],[]).
prefixo([(X,_)|T], [X|T2]):- prefixo(T,T2).

list_member(X,[X|_]).
list_member(X, [_|TAIL]) :- list_member(X,TAIL).

list_append(A,T,T) :- list_member(A,T),!.
list_append(A,TAIL,[A|TAIL]).



copy(L,R) :- accCp(L,R).
accCp([],[]).
accCp([H|T1],[H|T2]) :- accCp(T1,T2).

catena([], L, L).
catena([X|Xs], L, [X|Y]) :- catena(Xs, L, Y).

%removeAll(_, [], []).   %consider the case that the source list is empty. This is also the stop condition.
%removeAll(X, [X|T], L):- removeAll(X, T, L), !.  %if the element is the Head of the List, don't copy it to the Result list, and continue the recursive call with the Tail.
%removeAll(X, [H|T], [H|L]):- removeAll(X, T, L ).  %Third clause, copy the element in the Head of the list to the Result list, and continue with the recursive call with the Tail. 

auxiliar([],A,A).
codifica1(A,[A]).
codifica1([],[],[]).

codifica1([(A,B) | T], L, P) :-
    !,
    codifica1(A, L0),
    append(L0, [], R),
    append(B, [], Q),

    codifica1(T, R, Q).


prefixo(A,[A]).
prefixo((A,B), L) :-
    !,
    prefixo(A, L0),
    prefixo(B, L1),
    append(L0,[],L),
    append(L1,[],X).


app(X, [], [X]).
app(X, [Y | S], [Y | S2]) :- app(X, S, S2).


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

%%%%%%%%%%%%%%%%%%%%%%%%%
letter(X,Y) :- member(X, Y).   %em backtrack member faz a; b;c

descodifica_rec(_,[], []).  %recursao final onde a lista de palavras = vazia, pois já codificamos todos os codigos para letras
descodifica_rec([(A,B) | Xs], [H|T], [C1 |Rc]) :-
    descodifica_1codigo([(A,B) | Xs], H, C1),
    descodifica_rec([(A,B) | Xs], T,Rc).