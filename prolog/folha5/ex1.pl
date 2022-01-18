% a
double(X,Y):- Y is X*2.

map(_, [], []).

map(Pred, [H|L], [X|Res]):-
  Term =.. [Pred, H, X],
  Term,
  map(Pred, L, Res).

% b
sum(A, B, S):- S is A+B.

fold(_, FinalValue, [], FinalValue).

fold(Pred, StartValue, [H|T], FinalValue):-
  Term =.. [Pred, StartValue, H, X],
  Term,
  fold(Pred, X, T, FinalValue).

% c
even(X):- 0 =:= X mod 2.

separate([], _, [], []).

separate([H|T], Pred, [H|Yes], No):-
  Term =.. [Pred, H],
  Term,
  separate(T, Pred, Yes, No).

separate([H|T], Pred, Yes, [H|No]):-
  separate(T, Pred, Yes, No).

% d
ask_execute:-
  read(Goal),
  Goal.
