:- use_module(library(between)).

% jogo(Jornada, EquipaCasa, EquipaVisitante, Resultado)
jogo(1,sporting,porto,1-2).
jogo(1,maritimo,benfica,2-0).
jogo(2,sporting,benfica,0-2).
jogo(2,porto,maritimo,1-0).
jogo(3,maritimo,sporting,1-1).
jogo(3,benfica,porto,0-2).

% treinadores(Equipas,[[JornadaInicial-JornadaFinal]-Treinador|Lista])
treinadores(porto,[[1-3]-sergio_conceicao]).
treinadores(sporting,[[1-2]-silas,[3-3]-ruben_amorim]).
treinadores(benfica,[[1-3]-bruno_lage]).
treinadores(maritimo,[[1-3]-jose_gomes]).

% 1
n_treinadores(Equipa,Numero):-
  treinadores(Equipa,Treinadores),
  length(Treinadores,Numero).

% 2
jornadas_treinador(Treinador,[Jornadas-Treinador|_],Jornadas).
jornadas_treinador(Treinador,[_|Rest],Jornadas):-
  jornadas_treinador(Treinador,Rest,Jornadas).
  
n_jornadas_treinador(Treinador,NumeroJornadas):-
  treinadores(_,Treinadores),
  jornadas_treinador(Treinador,Treinadores,[JornadaInicial-JornadaFinal]),
  NumeroJornadas is JornadaFinal - JornadaInicial + 1.

% 3
ganhou(Jornada,EquipaVencedora,EquipaDerrotada):-
  jogo(Jornada,EquipaVencedora,EquipaDerrotada,GolosCasa-GolosVisitante),
  GolosCasa > GolosVisitante.
ganhou(Jornada,EquipaVencedora,EquipaDerrotada):-
  jogo(Jornada,EquipaDerrotada,EquipaVencedora,GolosCasa-GolosVisitante),
  GolosCasa < GolosVisitante.

% 7
predX(N,N,_).
predX(N,A,B):-
  !, A\=B,
  NextA is A + sign(B-A),
  predX(N,NextA,B).

% 8
equipa_treinador(Treinador,Equipa):- 
  treinadores(Equipa,[[_]-Treinador]).

treinador_bom(Treinador):-
  treinadores(Equipa,Treinadores),
  jornadas_treinador(Treinador,Treinadores,[JornadaInicial-JornadaFinal]), !,
  findall(Jornada,(between(JornadaInicial,JornadaFinal,Jornada), 
                   \+ganhou(Jornada,Equipa,_)), Derrotas),
  length(Derrotas,0).

% 9
imprime_totobola(1,'1').
imprime_totobola(0,'X').
imprime_totobola(-1,'2').

imprime_texto(X,'vitoria da casa'):- X = 1.
imprime_texto(X,'empate'):- X = 0.
imprime_texto(X,'derrota da casa'):- X = -1.

resultado(Jornada,EquipaCasa,EquipaVisitante,Resultado):-
  ganhou(Jornada,EquipaCasa,EquipaVisitante),
  Resultado = 1.
resultado(Jornada,EquipaCasa,EquipaVisitante,Resultado):-
  ganhou(Jornada,EquipaVisitante,EquipaCasa),
  Resultado = -1.
resultado(_,_,_,Resultado):- Resultado = 0.

imprime_jogos(F):-
  jogo(Jornada,EquipaCasa,EquipaVisitante,_),
  resultado(Jornada,EquipaCasa,EquipaVisitante,Resultado),
  format('Jornada ~d: ~s x ~s - ',[Jornada,EquipaCasa,EquipaVisitante]),
  Pred =.. [F,Resultado,Print], Pred, 
  write(Print),nl,
  fail.
imprime_jogos(_).

% 12
lista_treinadores(L):-
  findall(Treinador, (treinadores(_, Treinadores),
                      jornadas_treinador(Treinador,Treinadores,_)), L).

% 13
:- use_module(library(lists)).

duracao_treinadores(L):-
  findall(NumeroJornadas-Treinador,(n_jornadas_treinador(Treinador,NumeroJornadas)), List),
  sort(List,Sorted),
  reverse(Sorted,L).

% 14
pascal(1,[1]):-!.
pascal(N,L):-
  N1 is N-1,
  pascal(N1,L1),
  append([0|L1],[0],L2),
  pascal_(L2,[],L),!.
  
pascal_([_|[]],Res,Res).
pascal_([E1,E2|L],Curr,Res):-
  E is E1+E2,
  append(Curr,[E],NewCurr),
  pascal_([E2|L],NewCurr,Res).

% 4 / % 5 / % 6 / % 10 / % 11 ----------> falta fazer
