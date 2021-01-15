e(lisboa,santarem).  /* existe uma estrada entre estes dois sitios */
e(santarem,coimbra).
e(santarem,caldas).
e(caldas,lisboa).
e(coimbra,porto).
e(lisboa,evora).
e(evora,beja).
e(lisboa,faro).
e(beja,faro).

cam(A,B) :- cam(A,B,A).

cam(A,B,X) :- a(A,B), nao_figura(B,X).
cam(A,B,X) :- a(A,C), nao_figura(C,X), cam(C,B,c(C,X)).

caminho(K) :- no(k).
caminho(c(N,KK)) :- no(N), caminho(KK).

nao_figura(N,K) :- \+ figura(N,K).

figura(N,N).
figura(N,c(N,_)).
figura(N,c(-,K)) :- figura(N,K).