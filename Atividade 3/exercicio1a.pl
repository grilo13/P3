/**NUMERAIS DE PEANO
 Predicado 1) z é um numeral, um numero.
 Predicado 2) se X é um numeral, s(X) também o é
 z é equivalente a 0, s(z) o seu sucessor....*/

num(z).
num(s(X)) :- num(X).