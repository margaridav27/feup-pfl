% 4. a, b, d, e, i

:-use_module(library(between)).
:-use_module(library(lists)).

% a
print_n(S, 0):- !.
print_n(S, N):-
  N > 0,
  write(S),
  NewN is N - 1,
  print_n(S, NewN).

% b
print_text(Text, Symbol, Padding):-
  write(Symbol),
  print_n(' ', Padding),
  write(Text),
  print_n(' ', Padding),
  write(Symbol).

% d
/* minha
read_input(Curr, Res):- 
  peek_code(Ascii), 
  Ascii == 10,
  reverse(Curr, Rev),
  number_codes(Res, Rev).

read_input(Curr, Res):-
  peek_code(Ascii),
  between(47, 58, Ascii),
  get_code(Ascii),
  read_input([Ascii|Curr], Res).

read_number(Res):- read_input([], Res). */

/* joni
read_number(Num):- read_number(Num, "0").

read_number(Num, RevList):-
  peek_code(10), !, skip_line,
  reverse(RevList, List),
  number_codes(Num, List).

read_number(Num, RevList):-
  get_code(Ascii),
  between(47, 58, Ascii), !,
  read_number(Num, [Ascii|RevList]).

read_number(Num, RevList):- read_number(Num, RevList). */

% prof
read_number(Num):- read_number(Num, 0).

read_number(Num, Num):- peek_code(10), !, skip_line.

read_number(Num, Prev):-
  get_code(Ascii),
  char_code('0', AsciiZero),
  N is Ascii - AsciiZero,
  between(0, 9, N), !,
  Next is Prev * 10 + N,
  read_number(Num, Next). 

% e
read_until_between(Min, Max, Value):-
  read_number(Value),
  between(Min, Max, Value),
  write(Value).