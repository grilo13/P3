/**zero é menor ou igual do que qualquer coisa*/

/** LESS OR EQUAL THAN */
le(z,_).    
le(s(A),s(B)) :- le(A,B).

/** LESS THAN */
lt(z,s(z)).
lt(s(A),s(B)) :- lt(A,B).

