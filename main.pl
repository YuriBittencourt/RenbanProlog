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
