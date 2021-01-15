listSum([], 0).

listSum([H|T], TotalSum) :- 
listSum(T, Sum1), 
TotalSum is H + Sum1.