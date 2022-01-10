% 7.a
list_append([], L2, L2).

list_append([H|T1], L2, [H|T3]):- list_append(T1, L2, T3).

% 7.b
list_member(E, [E|_]).

list_member(E, [H|T]) :- list_member(E,T).

% 7.c
list_last([H|[]], H).

list_last([H|T], E) :- list_last(T, E).

% 7.d
list_nth_aux(N, N, [H|T], H).

list_nth_aux(CurrN, N, [H|T], E):-
    NextN is CurrN + 1,
    list_nth_aux(NextN, N, T, E).

list_nth(N, L, E):-
    list_nth_aux(0, N, L, E).

% 7.e
