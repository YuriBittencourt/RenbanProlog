:- [testcases].
:- use_module(library(clpfd)).


% Retorna o número de grupos do puzzle
numGrupos(I, Max) :- matrizsecundaria(I, Matriz), flatten(Matriz, L), max_list(L, Max1), Max is Max1 + 1.

% Retorna o Grupo da posição (I, J)
getGrupoElem(Id, I, J, Elemento) :- matrizsecundaria(Id, Matriz), nth0(I, Matriz, L), nth0(J, L, Elemento).

% Retorna o Elemento na posição (I, J) de uma matriz Matriz
getElemento(Matriz, I, J, Elemento) :- nth0(I, Matriz, L), nth0(J, L, Elemento).

% Retorna o grupo identificado por NroGrupo
getGrupo(Id, Matriz, NroGrupo, Grupo) :- findall(Elemento, (getElemento(Matriz, I, J, Elemento), getGrupoElem(Id, I, J, NroGrupo), Elemento \= 0), Grupo).

% Checa se há uma sequência númerica em uma lista
eh_sequencia([])        :- !.
eh_sequencia([_])       :- !.
eh_sequencia([Hx, Hy|T]) :- Hx + 1 #= Hy, eh_sequencia([Hy|T]).

% Ordena um grupo e chama eh_sequencia
sequenciaValida(Grupo) :- sort(Grupo, GrupoOrdenado), eh_sequencia(GrupoOrdenado).

% Retorna uma lista de listas sendo cada lista interna um grupo, no entanto o Prolog trás tudo como uma lista flat
getAllGrupos(Id, Matriz, Lst) :- bagof(Grupo, (numGrupos(Id, N), NroGrupo #>= 0, NroGrupo #=< N, getGrupo(Id, Matriz, NroGrupo, Grupo)), Lst).

% A estrutura desse predicado foi retirada do site 'https://www.swi-prolog.org/pldoc/man?section=clpfd-sudoku', que contém um resolvedor de sudoku.
renban(Id, Mp) :- n(Id, N),
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
