airport('Aeroporto Francisco Sá Carneiro','LPPR','Portugal').
airport('Aeroporto Humberto Delgado','LPPT','Portugal').
airport('Aeroporto Adolfo Suarez Madrid-Barajas','LEMD','Spain').
airport('Aeroporto de Paris-Charles-de-Gaule Roissy Airport','LFPG','France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci','LIRF','Italy').

company('TAP','TAP Air Portugal',1945,'Portugal').
company('RYR','Ryanair',1984,'Ireland').
company('AFR','Société Air France, S.A.',1933,'France').
company('BAW','British Airways',1974,'United Kingdom').

flight('TP1923','LPPR','LPPT',1115,55,'TAP').
flight('TP1968','LPPT','LPPR',2235,55,'TAP').
flight('TP842','LPPT','LIRF',1450,195,'TAP').
flight('TP843','LIRF','LPPT',1935,195,'TAP').
flight('FR5483','LPPR','LEMD',630,105,'RYR').
flight('FR5484','LEMD','LPPR',1935,105,'RYR').
flight('AF1024','LFPG','LPPT',940,155,'AFR').
flight('AF1025','LPPT','LFPG',1310,155,'AFR').

% 1
short(Flight):-
  flight(Flight,_,_,_,Duration,_),
  Duration < 90.

% 2
shorter(F1,F2,Shorter):-
  flight(F1,_,_,_,D1,_),
  flight(F2,_,_,_,D2,_),
  D1 < D2,
  Shorter = F1.
shorter(F1,F2,Shorter):-
  flight(F1,_,_,_,D1,_),
  flight(F2,_,_,_,D2,_),
  D2 < D1,
  Shorter = F2.

% 3
arrival(Flight,Arrival):-
  flight(Flight,_,_,Departure,Duration,_),
  DepMinutes is Departure mod 100,
  DepHours is Departure // 100,
  DurMinutes is Duration mod 60,
  DurHours is Duration // 60,
  TotalMinutes is (DepMinutes + DurMinutes) mod 60,
  TotalHours is DepHours + DurHours + ((DepMinutes + DurMinutes) // 60),
  Arrival is TotalHours * 100 + TotalMinutes. 

% 4
operates(Company,Country):-
  flight(_,Origin,_,_,_,Company),
  airport(_,Origin,Country).
operates(Company,Country):-
  flight(_,_,Destination,_,_,Company),
  airport(_,Destination,Country).

countries(Company, Countries) :-
  countries(Company, [], Countries).

countries(Company, Acc, Countries) :-
  operates(Company,Country),
  \+ member(Country, Acc), !,
  countries(Company, [Country|Acc], Countries). 
countries(_, Countries, Countries).

% 5
closeEnough(T1,T2):-
  HoursT1 is T1 // 100,
  MinutesT1 is T1 mod 100,
  HoursT2 is T2 // 100,
  MinutesT2 is T2 mod 100,
  HoursDiff is HoursT2 - HoursT1,
  MinutesDiff is abs(MinutesT2 - MinutesT1),
  Diff is HoursDiff * 60 + MinutesDiff,
  Diff >= 30,
  Diff =< 90.

pairableFlights:-
  flight(F1,_,D,_,_,_),
  flight(F2,D,_,DepF2,_,_),
  F1 \= F2,
  arrival(F1,ArrF1),
  closeEnough(ArrF1,DepF2),
  format('~s - ~s \\ ~s\n',[D,F1,F2]), 
  fail.
pairableFlights.

% 6
:- use_module(library(lists)).

timeAfterTrip(B,A):-
  BMins is B mod 100,
  BHours is B // 100,
  AMins is (BMins + 30) mod 60,
  AHours is BHours + ((BMins + 30) // 60),
  A is AHours * 100 + AMins.

dayIncrement(B,A,I):- B > A, I = 1.
dayIncrement(_,_,0).

tripDays(Trip,Time,Flights,Days):- tripDays(Trip,Time,Time,[],Flights,1,Days).
tripDays([_|[]],_,_,AccFlights,Flights,Days,Days):- reverse(AccFlights,Flights).
tripDays([From,To|Rest],AccTime,Time,AccFlights,Flights,AccDays,Days):-
  % find a flight from origin country to destination country
  airport(_,CodeTo,From),
  airport(_,CodeFrom,To),
  flight(Flight,CodeTo,CodeFrom,Departure,_,_),

  % calculate arrival on that country and check if it translates into an additional day
  arrival(Flight,Arrival),
  dayIncrement(AccTime,Arrival,I1),
  AccDays1 is AccDays + I1,

  % calculate time after visit that country and check if it translates into an additional day
  timeAfterTrip(Arrival,AccTime1),
  dayIncrement(Arrival,AccTime1,I2),
  AccDays2 is AccDays1 + I2,
  
  % continue for the rest of the trip
  tripDays([To|Rest],AccTime1,Time,[Departure|AccFlights],Flights,AccDays2,Days).

% 7
avgFlightDurationFromAirport(Airport,Avg):-
  findall(Duration,flight(_,Airport,_,_,Duration,_),Durations),
  sumlist(Durations,Sum),
  length(Durations,Number),
  Avg is Sum / Number.

% 8
getMaximumNumber(Max):-
  findall(Number, (
    company(Company,_,_,_),
    countries(Company,Countries),
    length(Countries,Number)
  ), Numbers),
  sort(Numbers,Sorted),
  reverse(Sorted,Descending),
  nth1(1,Descending,Max).

mostInternation(ListOfCompanies):-
  getMaximumNumber(Max),
  findall(Company, (
    company(Company,_,_,_),
    countries(Company,Countries),
    length(Countries,Number),
    Number == Max
  ), ListOfCompanies).



% 9
difMax2(X,Y):-
  X < Y,
  X >= Y - 2.

/* ---- antes (cut vermelho!) ----
makePairs(L,P,[X-Y|Zs]):-
  select(X,L,L2),
  select(Y,L2,L3),
  G =.. [P,X,Y], G, !
  makePairs(L3,P,Zs).
makePairs([],_,[]).
*/

makePairs1(L,P,[X-Y|Zs]):-
  select(X,L,L2),
  select(Y,L2,L3),
  G =.. [P,X,Y], G,
  makePairs1(L3,P,Zs).
makePairs1([],_,[]).

% 10
makePairs2(L,P,[X-Y|Zs]):-
  select(X,L,L2),
  select(Y,L2,L3),
  G =.. [P,X,Y], G,
  makePairs2(L3,P,Zs).
makePairs2(_,_,[]).

%11
getMaxPair([], S, _, S).
getMaxPair([Cur|Next], S, Counter, Temp):-
  length(Cur, Length),
  Length > Counter,
  getMaxPair(Next, S, Length, Cur).
getMaxPair([Cur|Next], S, Counter, Temp):-
  getMaxPair(Next, S, Counter, Temp).
  
makeMaxPairs(L, P, S):-
  setof(Res, makePairs(L,P, Res), SS),
  getMaxPair(SS, S, 0, Temp).

%12
/* 
(1,1)            2 baixo, 1 dir 
(3,2)  / (2,3)   3 baixo, 2 dir 
(6,4)  / (4,6)   2 baixo, 1 dir  
(8,5)  / (5,8)   3 baixo, 2 dir 
(11,7) / (7,11)  2 baixo, 1 dir
(13,8) / (8,13)  ...

a cada iteração soma-se ao primeiro par de coordenadas o incremento correspondente
gerando um novo par de coordenadas para adicionar à lista (e adiciona-se também o simétrico) */

stateMachine(N, 2-3, [(NewX, NewY), (NewY, NewX)|List], (X,Y)):-
  NewX is X + 2,
  NewY is Y + 3,
  NewX =< N,
  NewY =< N,
  stateMachine(N, 1-2, List, (NewX, NewY)).
stateMachine(N, 1-2, [(NewX, NewY), (NewY, NewX)|List], (X,Y)):-
  NewX is X + 1,
  NewY is Y + 2,
  NewX =< N,
  NewY =< N,
  stateMachine(N, 2-3, List, (NewX, NewY)).
stateMachine(_, _, [], _).

whitoff(N, [(1,1)|W]):-
  stateMachine(N, 1-2, W, (1,1)).
