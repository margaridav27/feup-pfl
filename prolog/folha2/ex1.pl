% 1.c
fibonacciAux(N, N, F1, F, F).
fibonacciAux(N, CurrN, F1, F2, F):- 
    N > 0,
    CurrN < N,
    NextF1 is F2,
    NextF2 is F1 + F2,
    NextN is CurrN + 1,
    fibonacciAux(N, NextN, NextF1, NextF2, F).

fibonacci(0, 0).
fibonacci(N, F):- 
    N > 0,
    fibonacciAux(N, 1, 0, 1, F).

% 1.d
isPrimeAux(N, N).
isPrimeAux(N, CurrN):-
    CurrN < N,
    N mod CurrN =\= 0,
    NextN is CurrN + 1,
    isPrimeAux(N, NextN).

isPrime(1).
isPrime(N):-
    N > 1,
    isPrimeAux(N, 2).
