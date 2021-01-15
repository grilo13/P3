soma(z,X,X).
soma(s(X), Y, s(Z)) :- soma(X,Y,Z).

sub(X,z,X).
sub(Y,s(X),Z) :- sub(Y,X,s(Z)).

mult(X,z,z).
mult(A, s(B), X) :- mult(A, B, Y), soma(A,Y,X).

%Divisão no caso de A ser divisel por B
%div(A,B,X) :- mult(X,B,A).

%Divisão no caso de A não ser divisel por B
div(A,B,Q,R) :- 
        mult(B,Q,X),
        soma(X,R,A),
        lt(R,B).




