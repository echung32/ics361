% base case
dup([],[]).
% take out the duplicates
% given dup([a,b,c],[a,a,b,b,c,c]).
dup([A|R], [A,A|D]) :-
    dup(R, D).