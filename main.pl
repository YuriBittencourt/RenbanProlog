:- [testcases].
:- use_module(library(clpfd)).


% Retorna o número de grupos do puzzle
numGrupos(I, Max) :- matrizsecundaria(I, M), flatten(M, L), max_list(L, Max1), Max is Max1 + 1.

% Retorna o Grupo da posição (I, J)
getGrupoElem(Id, I, J, Elemento) :- matrizsecundaria(Id, M), nth0(I, M, L), nth0(J, L, Elemento).

% Retorna o Elemento na posição (I, J) de uma matriz M
getElemento(M, I, J, Elemento) :- nth0(I, M, L), nth0(J, L, Elemento).

% Retorna o grupo identificado por NroGrupo
getGrupo(Id, M, NroGrupo, Grupo) :- findall(Elemento, (getElemento(M, I, J, Elemento), getGrupoElem(Id, I, J, NroGrupo), Elemento \= 0), Grupo).


getAllGrupos(Id, M, Lst) :- bagof(Grupo, (getGrupo(Id, M, Index, Grupo), numGrupos(Id, N), I #>= 0, I #=< N), Lst).


% Checa se há uma sequência númerica em uma lista
eh_sequencia([])        :- !.
eh_sequencia([_])       :- !.
eh_sequencia([X, Y|Xs]) :- X + 1 #= Y, eh_sequencia([Y|Xs]).

% Ordena um grupo e chama eh_sequencia
sequenciaValida(Grupo) :- sort(Grupo, GrupoOrdenado), eh_sequencia(GrupoOrdenado).

renban(Id, Mp) :- n(Id, N), length(Mp, N),
                 maplist(same_length(Mp), Mp),
                 append(Mp, Vs), Vs ins 1..N,
                 maplist(all_distinct, Mp),
                 transpose(Mp, MpColunas),
                 maplist(all_distinct, MpColunas),
                 Mp = [As, Bs, Cs, Ds, Es, Fs, Gs, Hs, Is],
                 blocks(As, Bs, Cs),
                 blocks(Ds, Es, Fs),
                 blocks(Gs, Hs, Is).

blocks([], [], []).
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
        blocks(Ns1, Ns2, Ns3).
