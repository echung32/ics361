% X = find element in list
% L = list
% Z = index of found element

% base case
kth(X, [X|_], 1).

kth(X, [_|R], K) :-
    K > 1,
    N is K - 1,
    kth(X, R, N).
