#main :- write('hello world').

friendof(A,C) :- friend(A,B) , friend(B,C).

isfriendaboy(A,B) :- friend(B,A), boy(A).
isfriendgirl(A,B) :- friend(B,A), girl(A).

issamedegree(A,B) :- degree(A,X), degree(B,X).

friend(pedro,diogo).
friend(pedro,castanho).
friend(pedro,ruben).    
friend(pedro,cris).

friend(diogo,manuel).
friend(castanho,oly).
friend(diogo,julia).

boy(pedro).
boy(diogo).
boy(castanho).
boy(ruben).
boy(manuel).
boy(oly).

girl(julia).
girl(beatriz).
girl(cris).

degree(pedro,informatica).
degree(castanho,informatica).
degree(ruben,informatica).
degree(beatriz,bioquimica).


