% 6. a, b, e, g

professor(adalberto).
professor(bernardete).
professor(capitolino).
professor(diogenes).
professor(ermelinda).

aluno(alberto).
aluno(bruna).
aluno(cristina).
aluno(diogo).
aluno(eduarda).
aluno(antonio).
aluno(bruno).
aluno(duarte).
aluno(eduardo).
aluno(bernardo).
aluno(clara).
aluno(diana).
aluno(eurico).
aluno(claudio).
aluno(eva).
aluno(alvaro).
aluno(beatriz).

leciona(adalberto,algoritmos).
leciona(bernardete,'base de dados').
leciona(capitolino,compiladores).
leciona(diogenes,estatistica).
leciona(ermelinda,redes).

frequenta(alberto,algoritmos).
frequenta(alberto,compiladores).
frequenta(bruna,algoritmos).
frequenta(bruna,estatistica).
frequenta(cristina,algoritmos).
frequenta(cristina,'base de dados').
frequenta(antonio,'base de dados').
frequenta(antonio,estatistica).
frequenta(claudio,estatistica).
frequenta(claudio,redes).
frequenta(duarte,'base de dados').
frequenta(duarte,estatistica).
frequenta(eduardo,'base de dados').
frequenta(eduardo,redes).
frequenta(diana,compiladores).
frequenta(diana,redes).
frequenta(diogo,algoritmos).
frequenta(eduarda,algoritmos).
frequenta(eurico,compiladores).
frequenta(bruno,'base de dados').
frequenta(bernardo,compiladores).
frequenta(clara,compiladores).
frequenta(eva,estatistica).
frequenta(alvaro,redes).
frequenta(beatriz,redes).

% a
teachers(T):-
  findall(Teacher, professor(Teacher), T).

% e
common_course(S1, S2, UC):-
  frequenta(S1, UC),
  frequenta(S2, UC),
  S1 \= S2.
  
common_courses(S1, S2, C) :- 
  setof(UC, common_course(S1, S2, UC), C), !.

common_courses(S1, S2, []).

% g
strangers_(S1, S2):- 
  aluno(S1), 
  aluno(S2), 
  S1 \= S2,
  common_courses(S1, S2, C),
  length(C, 0).

strangers(L):-
  findall(S1-S2, strangers_(S1, S2), L).
