father(X,Y) :- 
    parent(X,Y), 
    male(X).
mother(X,Y) :- 
    parent(X,Y), 
    female(X).
child(X,Y) :- 
    parent(Y,X).
grandparent(X,Y) :- 
    parent(X,_Z), 
    parent(_Z,Y). 
% X é meu avô se X for pai do meu pai ou da minha mãe
grandfather(X,Y) :- 
    father(X,_Z), 
    parent(_Z,Y). 
% X é minha avó se X for mãe do meu pai ou da minha mãe
grandmother(X,Y) :- 
    mother(X,_Z), 
    parent(_Z,Y). 
% X e Y são irmãos se tiverem os mesmos progenitores
sibling(X,Y) :- 
    parent(A,X), 
    parent(B,Y), 
    parent(A,X), 
    parent(B,Y), 
    A\==B. 
% X e Y são meios irmãos se tiverem um e um só progenitor em comum
halfsibling(X,Y) :- 
    parent(A,X), 
    parent(B,X), 
    parent(B,Y), 
    parent(C,Y), 
    A\==B, 
    A\==C, 
    B\==C.
% X é meu tio se for irmão de um dos meus progenitores
uncle(X,Y) :- 
    sibling(X,_Z), 
    parent(_Z,Y).
% X é meu primo se for filho de um tio meu
cousin(X,Y) :- 
    child(Y,_Z), 
    uncle(_Z,X).

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
