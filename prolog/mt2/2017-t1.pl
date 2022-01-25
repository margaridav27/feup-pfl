:-dynamic played/4.

% player(Name, UserName, Age)
player('Danny','Best Player Ever',27).
player('Annie','Worst Player Ever',24).
player('Harry','A-Star Player',26).
player('Manny','The Player',14).
player('Jonny','A Player',16).

% game(Name, Categories, MinAge)
game('5 ATG',[action, adventure, open-world, multiplayer],18).
game('Carrier Shift: Game Over',[action, fps, multiplayer, shooter],16).
game('Duas Botas',[action, free, strategy, moba],16).

% played(Player, Game, HoursPlayed, PercentUnlocked)
played('Best Player Ever','5 ATG',3,83).
played('Worst Player Ever','5 ATG',52,9).
played('The Player','Carrier Shift: Game Over',44,22).
played('A Player','Carrier Shift: Game Over',48,24).
played('A-Star Player','Duas Botas',37,16).
played('Best Player Ever','Duas Botas',33,22).

% 1
achievedALot(Player):-
  player(Player,Username,_),
  played(Username,Game,_,Percentage),
  Percentage >= 80.

% 2
isAgeAppropriate(Name,Game):-
  player(Name,_,Age),
  game(Game,_,MinAge),
  Age >= MinAge.

% 3
timePlayingGames(Player,Games,Times,Sum):-
  timePlayingGamesAux(Player,Games,Times),
  sumlist(Times,Sum).

timePlayingGamesAux(_,[],[]).
timePlayingGamesAux(Player,[Game|Rest],[Time|Times]):-
  played(Player,Game,Time,_),
  timePlayingGamesAux(Player,Rest,Times).
timePlayingGamesAux(_,_,[0]).

% 4
listGamesOfCategory(Category):-
  game(Name,Categories,MinAge),
  member(Category,Categories),
  format('~s (~d)\n',[Name,MinAge]),
  fail.
listGamesOfCategory(_).

% 5
updatePlayer(Player,Game,Hours,Percentage):-
  played(Player,Game,PrevHours,PrevPercentage),
  PredA =.. [played,Username,Game,PrevHours,PrevPercentage],
  retract(PredA),
  UpdatedHours is PrevHours + Hours,
  UpdatedPercentage is PrevPercentage + Percentage,
  PredB =.. [played,Username,Game,UpdatedHours,UpdatedPercentage],
  assert(PredB).

% 6
fewHours(Player,Games):- 
  fewHours(Player,[],Games).

fewHours(Player,AccGames,Games):-
  played(Player,Game,Time,_),
  \+member(Game,AccGames),
  Time < 10,
  fewHours(Player,[Game|AccGames],Games).
fewHours(_,Games,Games).

% 7
ageRange(MinAge,MaxAge,Players):-
  ageRange(MinAge,MaxAge,[],Players).

ageRange(MinAge,MaxAge,AccPlayers,Players):-
  player(Name,_,Age),
  \+member(Name,AccPlayers),
  Age >= MinAge,
  Age =< MaxAge,
  ageRange(MinAge,MaxAge,[Name|AccPlayers],Players).
ageRange(_,_,Players,Players).

% 8
avgAge(Game,Avg):-
  avgAge(Game,[],[],Ages),
  length(Ages,NumAges),
  sumlist(Ages,SumAges),
  Avg is SumAges / NumAges.

avgAge(Game,AccPlayers,AccAges,Ages):-
  played(Player,Game,_,_),
  player(_,Player,Age),
  \+member(Player,AccPlayers),
  avgAge(Game,[Player|AccPlayers],[Age|AccAges],Ages).
avgAge(_,_,Ages,Ages).

% 9
getPlayersNames([],[]).
getPlayersNames([Name-_|Rest],[Name|Players]):-
  getPlayersNames(Rest,Players).

mostEffectivePlayers(Game,Players):-
  mostEffectivePlayers(Game,0,[],List),
  getPlayersNames(List,Players).

mostEffectivePlayers(Game,MaxEfficiency,AccPlayers,Players):-
  % get a player and calculte his efficiency
  played(Player,Game,Hours,Percentage),
  Efficiency is Percentage / Hours,
  \+member(Player-Efficiency,AccPlayers),

  % recalculate efficiency and remove those who are less efficient
  Efficiency >= MaxEfficiency,
  NewMaxEfficiency is Efficiency,
  removeLessEfficient(NewMaxEfficiency,AccPlayers,NewAccPlayers),

  % continue for the rest of the players
  mostEffectivePlayers(Game,NewMaxEfficiency,[Player-Efficiency|NewAccPlayers],Players).
mostEffectivePlayers(_,_,Players,Players).

removeLessEfficient(_,[],[]).
removeLessEfficient(Max,[Name-Efficiency|Players],[Name-Efficiency|Top]):- 
  Efficiency >= Max,
  removeLessEfficient(Max,Players,Top).
removeLessEfficient(_,_,_):- removeLessEfficient(_,_,_).

% 10

