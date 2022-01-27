% BFS

:- usemodule(library(Ls)).

connected(porto, lisbon).
connected(lisbon, madrid).
connected(lisbon, paris).
connected(lisbon, porto).
connected(madrid, paris).
connected(madrid, lisbon).
connected(paris, madrid).
connected(paris, belgium).

% procura(lisbon, belgium, Path) ?

procura(Start, End, TruePath):-
    procura([[Start]], End, [], Path),
    reverse(Path, TruePath).

procura([[Fim|Path]|_], Fim, _, [Fim|Path]).
procura([[X|From]|Res], Fim, Visitados, Path):-
  findall([Node,X|From],
         (connected(X, Node),
          +member(Node, Visitados),
          +member([Node|_], [[X|_]|Res])),
         Nodes),
  append(Res, Nodes, NewNodes),
  procura(NewNodes, Fim, [X|Visitados], Path).


% INSERTION SORT

insert(X, [], [X]):- !.
insert(X, [X1|L1], [X,X1|L1]):- X =< X1, !.
insert(X, [X1|L1], [X1|L]):- insert(X, L1, L).

iSort([], []):- !.
iSort([X|L], S):- iSort(L, S1), insert(X, S1, S).

% 4.1) existePadrao(+Str, +Padrao)

existePadrao(Str, Padrao):- stateMachine(Str, Padrao, 1).

stateMachine([], Padrao, Index):- reachEnd(Padrao, Index).
stateMachine(_, Padrao, Index):- reachEnd(Padrao, Index).
stateMachine([Char|Str], Padrao, Index):-
    nth1(Index, Padrao, Trigger),
    (Trigger == 43; Char == Trigger),
    NewIndex is Index +1,!,
    stateMachine(Str, Padrao, NewIndex).
stateMachine([Char|Str], Padrao, Index):-
    nth1(1, Padrao, First),
    (First == Char -> NewIndex = 2; NewIndex = 1),
    stateMachine(Str, Padrao, NewIndex).
reachEnd(Padrao, Index):-
    length(Padrao, Lenght),
    Index > Lenght.
