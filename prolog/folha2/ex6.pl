% 6.b
del_one_aux(H, [H|T], Curr, L):- 
    append(Curr, T, L).

del_one_aux(E, [H|T], Curr, L):-
    append(Curr, [H], Updated),
    del_one_aux(E, T, Updated, L).

del_one(E, L1, L2):-
    del_one_aux(E, L1, [], L2).


% 6.c
del_all_aux(E, [], L, L).

del_all_aux(H, [H|T], Curr, L):-
    del_all_aux(H, T, Curr, L).

del_all_aux(E, [H|T], Curr, L):-
    append(Curr, [H], Updated),
    del_all_aux(E, T, Updated, L).

del_all(E, L1, L2):-
    del_all_aux(E, L1, [], L2).


% 6.d
del_all_list(L1, L2, L2).

del_all_list([H|T], L1, L2):-
    del_all(H, L1, Curr),
    del_all_list(T, Curr, L2).

% 6.e
