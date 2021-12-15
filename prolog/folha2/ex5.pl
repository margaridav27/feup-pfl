% 5.b
listSumAux([], Sum, Sum).
listSumAux([H | T], CurrSum, Sum):- 
    NewSum is CurrSum + H,
    listSumAux(T, NewSum, Sum).

listSum(L, Sum):-
    listSumAux(L, 0, Sum).

% 5.d
innerProductAux([], [], []).
innerProductAux([H1 | T1], [H2 | T2], [Prod | T]):- 
    Prod is H1 * H2,
    innerProductAux(T1, T2, T).

innerProduct(L1, L2, S):-
    innerProductAux(L1, L2, RL),
    listSum(RL, S).
    
% 5.e
countAux(E, [], R, R).
countAux(H, [H | T], CurrR, R):- 
    NextR is CurrR + 1,
    countAux(H, T, NextR, R).
countAux(E, [H | T], CurrR, R):-
    countAux(E, T, CurrR, R).
count(E, L, R):-
    countAux(E, L, 0, R).

