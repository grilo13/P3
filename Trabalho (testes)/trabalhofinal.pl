#append([], X,X).
#append([X | Y], Z , [X | W]) :- append(Y,Z,W).

visit_pairs([]).
visit_pairs([(A, B)| Xs]) :- 
    writeln(first_pair(A)),
    visit_pairs(Xs).