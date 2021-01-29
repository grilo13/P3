%%%Predicado que faz a codificação recursiva de uma palavra
codifica_rec(_,[],[]).  %recursao final onde a lista de palavras = vazia, pois já codificamos todas as letras para codigos
codifica_rec([(A,B) | Xs], [H|T], [C1 |Rc]) :-
    codifica_1letra([(A,B) | Xs], H, C1),
    codifica_rec([(A,B) | Xs], T, Rc).

codifica_1letra([(L,C) | R], L ,C)  :- !.
codifica_1letra([_|R], L, C) :- codifica_1letra(R,L,C).

%%% Predicado que faz a descodificação recursiva de um código
descodifica_rec(_,[],[]).
descodifica_rec([(A,B) | Xs], L, [C1 |Rc]) :-
    append(X,Y,L),  %L = lista, Y =  resto, X = valor a codificar primeiro
    descodifica_1codigo([(A,B) | Xs],X,C1),
    descodifica_rec([(A,B) | Xs], Y, Rc).

descodifica_1codigo([(L,C) | R], C, L) :- !.
descodifica_1codigo([_|R], C,L) :- descodifica_1codigo(R,C,L).
    
%%% Predicado que gera todas as palavras entre um indice minimo N e um indice maximo M (inclusive)
gera_palavras(L,N,M,[]).
gera_palavras(L,N, M,[C|W]) :-   %N deve ser limite minimo e M limite maximo
    N =< M,
    N1 is N+1,
    member(C,L),
    gera_palavras(L,N1,M, W).    %chamada recursiva

%Predicado que retorna a lista de letras existentes no dicionário pretendido
%Irá ser usado para gerar todas as palavras comas respeticas letras
%Exemplo 1 do enunciado vai retornar -> X = [a,c,j,l,p,s,v] // Exemplo 2 do enunciado vai retornar -> X = [a,b,c,f,j,l,r]
prefixo([],[]).
prefixo([(X,_)|T], [X|T2]):- prefixo(T,T2).

%%% Predicado que concatena listas, que por sua vez estejam dentro de uma lista
%%% Exemplo -> [[0,1,0],[1,1]] = [0,1,0,1,1]
juntar_listas([], []) :- !.
juntar_listas([L|Ls], FlatL) :-
    !,
    juntar_listas(L, NewL),
    juntar_listas(Ls, NewLs),
    append(NewL, NewLs, FlatL).
juntar_listas(L, [L]).

%%% Predicado ambiguo = recebe como output o dicionário, e retorna o código ambiguo (P3), e as duas palavras que o codificam (P1 e P4)
ambiguo(L,P3,P1,P4) :-
    prefixo(L,P),    %retorna uma lista com as letras todas do dicionario [a,c,j,l,p,s,v]
    gera_palavras(P,1,2,P1),    %gera todas as palavras com as letras dadas, entre um tamanho dado
    codifica_rec(L,P1,P2),     
    juntar_listas(P2,P3),   %p3 mostra os valores de uma palavra codifica apenas numa lista [[0,1,0],[0,1,0]]  = [0,1,0,0,1,0] 
    descodifica_rec(L,P3,P4),  
    P1 \= P4. % P1 e P4 têm de ser diferentes -> a palavra codifica inicialmente, tem um código que pode ser igual para outra palavra também

%Exemplo 1 do enunciado
%ambiguo([(a, [0,1,0]),(c, [0,1]),(j, [0,0,1]),(l, [1,0]),(p, [0]),(s, [1]),(v, [1,0,1])], M, T1, T2)

%Exemplo2 do enunciado
%ambiguo([(a, [0,1,1,0]),(b, [0,1,1,1,1,1]),(c, [1,1,0,0,1,1,1,1]),(f, [1,0,1,1,1,0]),(j, [0,1,0]),(l, [0,1,0,0]),(r, [0,1,1,1,0])], M, T1, T2)

%Mostrar todas as palavras geradas (usada para testes)
%get_palavras_todas(L,N,M,X,Y) :- findall(X,gera_palavras(L,N,M,X),Y).