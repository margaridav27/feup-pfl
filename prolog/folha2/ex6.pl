% 6.a
push_front(E, L, [E|L]).

invert_aux([], L2, L2).

invert_aux([H|T], Curr, L2):- 
    push_front(H, Curr, Updated), 
    invert_aux(T, Updated, L2).

invert(L1, L2):- invert_aux(L1, [], L2).

% 6.b
del_one_aux(H, [H|T], Curr, L):- append(Curr, T, L).

del_one_aux(E, [H|T], Curr, L):-    
    append(Curr, [H], Updated),
    del_one_aux(E, T, Updated, L).

del_one(E, L1, L2):- del_one_aux(E, L1, [], L2).

% 6.c
del_all_aux(E, [], L, L).

del_all_aux(H, [H|T], Curr, L):- del_all_aux(H, T, Curr, L).

del_all_aux(E, [H|T], Curr, L):-
    append(Curr, [H], Updated),
    del_all_aux(E, T, Updated, L).

del_all(E, L1, L2):- del_all_aux(E, L1, [], L2).

% 6.d
del_all_list([], L2, L2).

del_all_list([H|T], L1, L2):-
    del_all(H, L1, Curr),
    del_all_list(T, Curr, L2).

% TODO: 6.e

% 6.f
equal_lists([], []).

equal_lists([H|T1], [H|T2]):- equal_lists(T1, T2).

list_perm(L1, L2):-
    sort(L1, S1), sort(L2, S2),
    equal_lists(S1, S2).

% TODO: pensar em implementação sem fazer batota

% 6.g
replicate_aux(0, N, E, L, L).

replicate_aux(CurrN, N, E, CurrL, L):-
    CurrN > 0,
    append(CurrL, [E], Updated),
    NextN is CurrN - 1,
    replicate_aux(NextN, N, E, Updated, L).

replicate(N, E, L):- replicate_aux(N, N, E, [], L).

% 6.h
intersperse_aux(E, [], L, L).

intersperse_aux(E, [H|[]], Curr, L2):-
    append(Curr, [H], Updated),
    intersperse_aux(E, [], Updated, L2).

intersperse_aux(E, [H|T], Curr, L2):-
    append(Curr, [H], Updated1),
    append(Updated1, [E], Updated2),
    intersperse_aux(E, T, Updated2, L2).

intersperse(E, L1, L2):- intersperse_aux(E, L1, [], L2).

% 6.i
insert_elem_aux(CurrI, I, [], E, L, L).

insert_elem_aux(I, I, [H|T], E, CurrL, L):-
    append(CurrL, [E,H], UpdatedL),
    NextI is I + 1,
    insert_elem_aux(NextI, I, T, E, UpdatedL, L).

insert_elem_aux(CurrI, I, [H|T], E, CurrL, L):-
    append(CurrL, [H], UpdatedL),
    NextI is CurrI + 1,
    insert_elem_aux(NextI, I, T, E, UpdatedL, L).

insert_elem(I, L1, E, L2):- insert_elem_aux(0, I, L1, E, [], L2).

% 6.j
% reached the end of the list
delete_elem_aux(CurrI, I, [], E, L, L). 

% reached the given index and the element corresponds
delete_elem_aux(I, I, [E|T], E, CurrL, L):-   
    NextI is I + 1,
    delete_elem_aux(NextI, I, T, E, CurrL, L). 

% reached the given index but the element doesn't correspond
delete_elem_aux(I, I, [H|T], E, CurrL, L):-   
    append(CurrL, [H], UpdatedL),
    NextI is I + 1,
    delete_elem_aux(NextI, I, T, E, UpdatedL, L).

% given index has not been reached yet
delete_elem_aux(CurrI, I, [H|T], E, CurrL, L):- 
    append(CurrL, [H], UpdatedL),
    NextI is CurrI + 1,
    delete_elem_aux(NextI, I, T, E, UpdatedL, L).

delete_elem(I, L1, E, L2):- delete_elem_aux(0, I, L1, E, [], L2).

% TODO: responder à questão

% 6.k
replace_aux(CurrI, I, [], E, L, L).

replace_aux(I, I, [H|T], E, CurrL, L):-
    append(CurrL, [E], UpdatedL),
    NextI is I + 1,
    replace_aux(NextI, I, T, E, UpdatedL, L).

replace_aux(CurrI, I, [H|T], E, CurrL, L):-
    append(CurrL, [H], UpdatedL),
    NextI is CurrI + 1,
    replace_aux(NextI, I, T, E, UpdatedL, L).

replace(I, L1, E, L2):- replace_aux(0, I, L1, E, [], L2).
