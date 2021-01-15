list_tuple([A, B], (A, B)).
list_tuple([A|T], (A, B)) :-
    list_tuple(T, B).

conv((_, L), R) :-
list_tuple(L, R).

convlist(As, Bs) :-
maplist(conv, As, Bs).