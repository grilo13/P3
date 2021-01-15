memberCheckSimple([H|T], H).  #if element is in the head of the list, it is an element of the list
memberCheckSimple([_|T], H) :- memberCheckSimple(T,H). #if it is member of the tail, it is ele of the list

member(X, [X|_]). 
member(X, [_|T]) :- member(X,T).

