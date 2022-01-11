% 1. a b c

:-dynamic male/1, female/1, parent/2.

female(grace).
female(dede).
female(claire).
female(haley).
female(alex).
female(poppy).

male(mitchell).
male(frank).
male(jay).
male(phil).
male(dylan).
male(luke).
male(george).

parent(grace, phil).
parent(frank,phil).
parent(dede,claire).
parent(jay,claire).
parent(phil,haley).
parent(phil,alex).
parent(phil,luke).
parent(claire,haley).
parent(claire,alex).
parent(claire,luke).
parent(dylan,george).
parent(dylan,poppy).
parent(haley,george).
parent(haley,poppy).

% a
add_person:-
  write('Insert a person to add.'), nl, read(Person), 
  write('Is it a male or a female?'), nl, read(Genre),
  add_person(Person, Genre).

add_person(Person, male):- assert(male(Person)).
add_person(Person, female):- assert(female(Person)).

% b
add_parents(Person):-
  write('Insert a parent to add.'), nl, read(P1),
  assert(parent(P1, Person)),
  write('Insert the other parent to add.'), nl, read(P2),
  assert(parent(P2, Person)).

add_parents(Person):-
  write('Insert a parent to add.'), nl, read(P1),
  assert(parent(P1, Person)),
  write('Insert the other parent to add.'), nl, read(P2),
  assert(parent(P2, Person)).

% c
remove_person:-
  write('Insert a person to remove.'), nl, read(Person), 
  remove_person(Person).

remove_person(Person):- 
  retract(male(Person)), 
  retractall(parent(_, Person)).

remove_person(Person):- 
  retract(female(Person)), 
  retractall(parent(_, Person)).
