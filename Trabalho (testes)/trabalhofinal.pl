%#append([], X,X).
%#append([X | Y], Z , [X | W]) :- append(Y,Z,W).

%codifica([],X,X).  
%codifica([(A,B)| Xs], L, [(A,B) | Y]) :-       %first argument is a list where [(A,B) | XS] the head is a tuple with (A,B) and the second one is list, third is also a list
%    codifica(Xs, L, Y).

%codifica([(A, B)| Xs], L, [(A,B) | Y]) :- 

%notrace

codifica(A,[A]).
codifica((A,B), L ,P) :-
    !,W
    codifica(A, L0),
    codifica(B, L1),
    append(L0,[],L),
    append(L1,[],P).

member(El, [H|T]) :- member_(T, El, H).

member_(_, El, El).
member_([H|T], El, _) :- member_(T, El, H).
%codifica1(L, X, Y) :- codifica1(L,X,Y).

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

%codifica1([(a,[1,0,1]),(b,[1,0,0])],X,Y).

codifica2(X, [], [X]).
codifica2([(A,B) | T], [H|R], P) :-


app(X, [], [X]).
app(X, [Y | S], [Y | S2]) :- app(X, S, S2).

rev(L,R) :- rev(L,[],R).

rev([], R,R).

rev([(A,C) | B], X, R) :- rev(B, [(A,C)|X], R).
    

/* descodifica(A,[A]).
descodifica((A,B), L, P) :-
    !,
    descodifica(A,L0),
    descodifica(B,L1),*/
