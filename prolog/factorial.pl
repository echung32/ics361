myfactorial(0, 1).

myfactorial(N, NFact) :-
    Z is N-1, % N new variable Z unified with N-1
    myfactorial(Z, ZFact), % N recursive call to unify ZFact with Z.
    NFact is N * ZFact. % NFact unified with N * ZFact
