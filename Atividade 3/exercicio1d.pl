%Converte um numeral de Peano em um numeral natural

num(z,0).
num(s(X), SY) :- num(X,Y), SY is Y+1.