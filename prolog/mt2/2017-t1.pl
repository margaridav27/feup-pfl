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

mostEfficientPlayer(Game,Players):-
  mostEfficientPlayer(Game,0,[],List), 
  getPlayersNames(List,Players).

mostEfficientPlayer(Game,MaxEfficiency,AccPlayers,Players):-
  % get a player and calculte his efficiency
  played(Player,Game,Hours,Percentage),
  Efficiency is Percentage / Hours,
  \+member(Player-Efficiency,AccPlayers), 

  % recalculate efficiency and remove those who are less efficient
  Efficiency >= MaxEfficiency, !,
  NewMaxEfficiency is Efficiency,
  removeLessEfficient(NewMaxEfficiency,AccPlayers,NewAccPlayers), !,

  % continue for the rest of the players
  mostEfficientPlayer(Game,NewMaxEfficiency,[Player-Efficiency|NewAccPlayers],Players).
mostEfficientPlayer(_,_,Players,Players).

removeLessEfficient(_,[],[]).
removeLessEfficient(Max,[Name-Efficiency|Players],[Name-Efficiency|Top]):- 
  Efficiency >= Max, !,
  removeLessEfficient(Max,Players,Top).
removeLessEfficient(Max,Players,Top):- 
  removeLessEfficient(Max,Players,Top).

% 10
% se Nick estiver instanciado, verifica se o jogador pode jogar todos os jogos (que joga) / se existe algum jogo que ele não tenha permissão de jogar (que joga)
% se Nick não estiver instanciado, verifica se o primeiro jogador na base de conhecimentos pode jogar todos os jogos (que joga)
% devido ao cut, no caso de Nick não estar instanciado, o predicado vai retornar no se o primeiro jogador que se tenta não puder jogar algum jogo
% ou seja, trata-se de um cut vermelho dado que a sua presença altera os resultados
canPlay(Nick):-
  player(_,Nick,Age), !,
  \+ (played(Nick,Game,_,_),
      game(Game,_,MinAge),
      MinAge > Age).

% 12
:- use_module(library(between)).
:- use_module(library(lists)).

% linha-coluna
matDist([[8],[8,2],[7,4,3],[7,4,3,1]]).
    
dist(_,E,E,0).
dist(Matrix,L,C,Dist):-
  C > L,
  dist(Matrix,C,L,Dist).
dist(Matrix,L,C,Dist):-
  RealL is L - 1, matDist(X),
  nth1(RealL,X,Row),
  nth1(C,Row,Dist).

areClose(MaxDist,Matrix,Pairs):-
  findall(L-C, (between(2,5,L),
                between(1,4,C),
                L \= C,
                dist(Matrix,L,C,D), 
                D =< MaxDist), 
          List), 
  removeSymmetrical(List,Pairs).

removeSymmetrical(List,Pairs):-
  removeSymmetrical(List,[],Pairs).

removeSymmetrical([],Pairs,Pairs).
removeSymmetrical([L-C|Rest],Acc,Pairs):-
  \+member(C-L,Acc),
  removeSymmetrical(Rest,[L-C|Acc],Pairs).
removeSymmetrical([_|Rest],Acc,Pairs):-
  removeSymmetrical(Rest,Acc,Pairs).

% 13
dendogram([1,[2,[5,[7,[8,australia,[9,[10,stahelena,angulia],georgiadosul]],reinounido],[6,servia,franca]],[3,[4,niger,india],irlanda]],brasil]).

distance(C1,C2,Dendogram,Dist):-
  lookup(C1,Dendogram,DistC1), !,
  lookup(C2,Dendogram,DistC2), !,
  Dist is max(DistC1,DistC2).

lookup(C,[Id,_,C],Id).          % right leef is the element we are looking for
lookup(C,[Id,C,_],Id).          % left leef is the element we are looking for
lookup(C,[_,_,[I,E,D]],Dist):-  % continue search for the right subtree
  lookup(C,[I,E,D],Dist).
lookup(C,[_,[I,E,D],_],Dist):-  % continue search for the left subtree
  lookup(C,[I,E,D],Dist).
