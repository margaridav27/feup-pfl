:- use_module(library(between)).
:- use_module(library(lists)).

% participant(Id,Age,Performance).
participant(1234,17,'Pe coxinho').
participant(3423,21,'Programar com os pes').
participant(3788,20,'Sing a bit').
participant(4865,22,'Pontes esparguete').
participant(8937,19,'Pontes de pen-drives').
participant(2564,20,'Moodle hack').

% performance(Id,Times).
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).

% 1
checkTimes([120|_]).
checkTimes([Time|Rest]):- 
  checkTimes(Rest).

madeItThrough(Participant):-
  performance(Participant,Times),
  checkTimes(Times).

% 2
juriTimes(Participants,JuriMember,Times,Total):-
  juriTimes(Participants,JuriMember,[],Times,0,Total).

juriTimes([],_,Times,Times,Total,Total).
juriTimes([P|Rest],JM,AccTimes,Times,AccTotal,Total):-
  performance(P,PTimes),
  nth1(JM,PTimes,Time),
  append(AccTimes,[Time],NewAccTimes),
  NewAccTotal is AccTotal + Time,
  juriTimes(Rest,JM,NewAccTimes,Times,NewAccTotal,Total).

% 3
patient(JuriMember):- 
  patient(JuriMember,0,[]).

patient(JuriMember,2,_).
patient(JuriMember,Acc,Visited):-
  participant(P,_,_),
  \+member(P,Visited),
  performance(P,Times),
  nth1(JuriMember,Times,Time),
  Time == 120,
  NewAcc is Acc + 1,
  patient(JuriMember,NewAcc,[P|Visited]).

% 4
bestParticipant(P1,P2,P):-
  performance(P1,T1),
  sumlist(T1,S1),
  performance(P2,T2),
  sumlist(T2,S2),
  getBest(P1,S1,P2,S2,P).

getBest(P1,S1,P2,S2,P):- S1 > S2, P = P1.
getBest(P1,S1,P2,S2,P):- S2 > S1, P = P2.

% 5
allPerfis:-
  participant(Id,_,Performance),
  performance(Id,Times),
  write(Id), write(':'),
  write(Performance), write(':'),
  write(Times), nl,
  fail.
allPerfis.

% 6
succeeded([]).
succeeded([Time|Rest]):-
  Time == 120,
  succeeded(Rest).

nSuccessfulParticipants(T):-
  findall(P,(
    performance(P,Times),
    succeeded(Times)
  ),Fails),
  length(Fails,T).

% 7
juriFans(L):-
  findall(P-J,(performance(P,Times),
               length(Times,NJuris),
               findall(Juri,(between(1,NJuris,Juri),
                             nth1(Juri,Times,Time),
                             Time == 120),J)),L).

% 8
eligibleOutcome(Id,Perf,TT):-
  performance(Id,Times),
  madeItThrough(Id),
  participant(Id,_,Perf),
  sumlist(Times,TT).

take_n(N,N,_,List,Result):- reverse(List,Result).
take_n(CurrN,N,[X|Rest],Acc,List):-
  NextCurrN is CurrN + 1,
  take_n(NextCurrN,N,Rest,[X|Acc],List).

take_n(N,Original,Result):-
  take_n(0,N,Original,[],Result).

nextPhase(N,Participants):-
  setof(TT-P-Perf,eligibleOutcome(P,Perf,TT),Eligible),
  length(Eligible,Total),
  Total >= N,
  sort(Eligible,Sorted),
  reverse(Sorted,Reverted),
  take_n(N,Reverted,Participants).

% 9
predX(Q,[R|Rs],[P|Ps]):-
  participant(R,I,P),
  I =< Q, !,
  predX(Q,Rs,Ps).
predX(Q,[R|Rs],Ps):-
  participant(R,I,_),
  I > Q,
  predX(Q,Rs,Ps).
predX(_,[],[]).
