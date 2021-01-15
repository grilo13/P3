# Add and multiplication example (really simple, no recursive done)

go :- write('Enter the first number: '), read(X),nl,
        write('Enter the second number: '), read(Y),nl,

        addandmultiply(X,Y).
    
addandmultiply(X,Y) :- 
            S is X+Y,
            M is X*Y,
            write('Addition is '), write(S),nl,
            write('Multiplication is '), write(M),nl.