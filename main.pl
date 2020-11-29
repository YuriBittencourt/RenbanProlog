:- [testcases].

numGrupos(I, Max) :- matrizsecundaria(I, M), flatten(M, L), max_list(L, Max1), Max is Max1 + 1.

getGrupoElem(Id, I, J, Elemento) :- matrizsecundaria(Id, M), nth0(I, M, L), nth0(J, L, Elemento).

getElemento(M, I, J, Elemento) :- nth0(I, M, L), nth0(J, L, Elemento).

getGrupo(Id, M, NroGrupo, Grupo) :- findall(Elemento, (getElemento(M, I, J, Elemento), getGrupoElem(Id, I, J, NroGrupo), Elemento \= 0), Grupo).

getAllGrupos(Id, M, Lst) :- findall(Grupo, getGrupo(Id, M, _, Grupo), Lst).


% Checa se há uma sequência númerica em uma lista
eh_sequencia([])        :- !.
eh_sequencia([_])       :- !.
eh_sequencia([X, Y|Xs]) :- X + 1 #= Y,
	                         eh_sequencia([Y|Xs]).

% Ordena um grupo e chama eh_sequencia
sequenciaValida(Grupo) :- sort(Grupo, GrupoOrdenado),
                          eh_sequencia(GrupoOrdenado).
