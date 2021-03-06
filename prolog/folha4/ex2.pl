% 2. a c d h

%flight(origin, destination, company, code, hour, duration).
flight(porto, lisbon, tap, tp1949, 1615, 60). 
flight(lisbon, madrid, tap, tp1018, 1805, 75). 
flight(lisbon, paris, tap, tp440, 1810, 150). 
flight(lisbon, london, tap, tp1366, 1955, 165). 
flight(london, lisbon, tap, tp1361, 1630, 160). 
flight(porto, madrid, iberia, ib3095, 1640, 80). 
flight(madrid, porto, iberia, ib3094, 1545, 80). 
flight(madrid, lisbon, iberia, ib3106, 1945, 80). 
flight(madrid, paris, iberia, ib3444, 1640, 125). 
flight(madrid, london, iberia, ib3166, 1550, 145). 
flight(london, madrid, iberia, ib3163, 1030, 140). 
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).

connected(Origin, Destination):- flight(Origin, Destination, _, _, _, _).

% a
get_all_nodes(Flights):-
  setof(Airport, (D, Co, C, H, D)^(flight(Airport, A, Co, C, H, D);
                                   flight(D, Airport, Co, C, H, D)) , Flights).

% c
find_flights(Origin, Destination, Flights):-
    dfs(Origin, Destination, [], [], Flights).

dfs(Origin, Origin, Flights, Codes, Codes).

dfs(Origin, Destination, Flights, Codes, [Code | Codes]):-
    flight(Origin, Destination, _, Code, _, _).

dfs(Origin, Destination, Flights, Codes, Res):-
    flight(Origin, Dest, _, Code, _, _),
    \+member(Dest, Flights),
    dfs(Dest, Destination, [Dest|Flights], [Code|Codes], Res)

% d 
% find_flights_breadth(Origin, Destination, Flights):-


% h
% find_circular_trip(MaxSize, Origin, Cycle):-
