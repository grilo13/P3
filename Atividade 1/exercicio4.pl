homem(joao).
homem(rui).
homem(ricardo).
mulher(maria).
mulher(ana).
mulher(rita).
mulher(silvia).

progenitor(joao, maria).
progenitor(joao, rui).
progenitor(manuel, joao).
progenitor(ricardo, manuel).
progenitor(ana, rui).
progenitor(rita, joao).
progenitor(rita, silvia).

pai(X, Y) :- homem(X), progenitor(X, Y).

avo(X,Y) :- progenitor(X,A), progenitor(A,Y).

antepassado(X,Y) :- progenitor(X,Y).
antepassado(X,Y) :- progenitor(A,Y), antepassado(X,A).

irmao(X,Y) :-  progenitor(A,X), progenitor(A,Y), (X \= Y).

tio(X,Y) :- progenitor(A,Y), irmao(A,X).