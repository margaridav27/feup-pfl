:-use_module(library(lists)).
:-use_module(library(between)).

% a
my_arg(Index, Term, Arg):-
  Index > 0,
  Term =.. G,
  nth(Index, Term, Arg).

my_functor(Term, Name, Arity):-
  var(Term), !,
  length(Args, Arity),
  Term =.. [Name | Args].

my_functor(Term, Name, Arity):-
  Term =.. [Name | Args],
  length(Args, Arity).

% b
univ(Term, [Name|Args]):-
  var(Term), !,
  length(Args, Arity),
  my_functor(Term, Name, Arity).

univ(Term, [Name|Args]):-
  my_functor(Term, Name, Arity),
  findall(Arg, (between(1, Arity, Index), 
                arg(Index, Term, Arg)), Args).

