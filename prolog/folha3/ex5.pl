% 5. a, d, e, h

parent(grace,phil).
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

child(X,Y) :- parent(Y,X).

% a
children(Person, Children) :- 
  findall(Child, parent(Person, Child), Children).

% d
couple(Couple):- 
  parent(P1, Child), 
  parent(P2, Child), 
  P1 \= P2,
  Couple = P1-P2.

% e
couples_list(List):- 
  setof(Couple, couple(Couple), List).

% h
parent_of_two(Parent) :- 
  setof(Child, parent(Parent, Child), Children),
  length(Children, NChildren),
  NChildren >= 2.

parents_of_two(Parents) :- 
  setof(Parent, parent_of_two(Parent), Parents).
