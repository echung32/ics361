% parition into 3 sublists
% sum of integers <= N.
% sublist length > 0

split3(Number, _) :-
    \+ check_len(Number),
    !, fail.

split3(_, List) :-
    \+ check_list(List),
    !, fail.

split3(_, List) :-
    var(List),
    print("SPLIT3/2: The first argument must be a defined list."),
    !, fail.

split3(Number, List) :-
    % split into three sublists
    split(List, A, B, C),
    % ensure that SumX <= Number
    sum_list(A, SumA),
    sum_list(B, SumB),
    sum_list(C, SumC),
    SumA =< Number,
    SumB =< Number,
    SumC =< Number.

% https://www.reddit.com/r/prolog/comments/1cgs7oy/how_to_split_list_into_n_sublists/
% Think about how the un-split and split list are related.
% The append/3 predicate can be used to split and join lists. 
% https://www.swi-prolog.org/pldoc/man?predicate=append/3
% append/3 --> PrefixList,SuffixList,PrefixSuffixList

% ?- listing(append).
% lists:append([], L, L). <-- Appending [] to L results in L itself.
% lists:append([H|T], L, [H|R]) :- <-- To get H, append T to L to get R.
%     append(T, L, R).

% To get L, instead remove H from R to get T (?)

% https://chatgpt.com/share/6729fc4f-2a04-8011-8503-d94790b00097
split(List, A, B, C) :-
    % List is already populated, but A and Rest are unknown
    % This means, we work backwords to find possible solutions that gave us List.
    % A will take H from List, and the rest R is given to L (Rest).
    my_append(A, Rest, List),
    A \= [], % make sure A isn't empty
    % B and C are unknown, but Rest is known.
    % B takes H from Rest, and the rest R is given to L (C).
    my_append(B, C, Rest),
    B \= [], % make sure B isn't empty
    C \= []. % make sure C isn't empty

% sum_list/2 -> list, sum
% sums the elements in the list
sum_list([], 0).
sum_list([Number | Rest], Sum) :-
    sum_list(Rest, NSum),
    Sum is NSum + Number.

% my_append/3 -> PrefixList, SuffixList, PrefixSuffixList.
% base case: PrefixList is empty, so PrefixSuffixList is just SuffixList.
my_append([], SuffixList, SuffixList).
% recursive case.
my_append([Head|Tail], SuffixList, [Head|Rest]) :-
    my_append(Tail, SuffixList, Rest).

% list_length_greater_than_0/1 -> list
% as long as it can be splittable, it's > 0.
% no need to count the length of the list.
% list_length_greater_than_0([_|_]).
% ?- list_length_greater_than_0(1).
% false.
% ?- list_length_greater_than_0([]).
% false.
% ?- list_length_greater_than_0([A]).
% true.
% ?- list_length_greater_than_0([A,B,C]).
% true.

% [trace]  ?- split([3,5,4], A, B, C).
% Call: (12) split([3, 5, 4], _28480, _28482, _28484) ? creep
% Call: (13) my_append(_28480, _29922, [3, 5, 4]) ? creep
% Exit: (13) my_append([], [3, 5, 4], [3, 5, 4]) ? creep
% ^^^ my_append([], SuffixList, SuffixList)
% Call: (13) []\=[] ? creep
% Fail: (13) []\=[] ? creep
% Redo: (13) my_append(_28480, _29922, [3, 5, 4]) ? creep
% Call: (14) my_append(_33990, _29922, [5, 4]) ? creep
% Exit: (14) my_append([], [5, 4], [5, 4]) ? creep
% Exit: (13) my_append([3], [5, 4], [3, 5, 4]) ? creep
%                       [3] from [3, 5, 4], H from List
%                       [5 4] given to L, R given to L.
% Call: (13) [3]\=[] ? creep
% Exit: (13) [3]\=[] ? creep
% Call: (13) my_append(_28482, _28484, [5, 4]) ? creep
% Exit: (13) my_append([], [5, 4], [5, 4]) ? creep
% Call: (13) []\=[] ? creep
% Fail: (13) []\=[] ? creepq
% Redo: (13) my_append(_28482, _28484, [5, 4]) ? creep
% Call: (14) my_append(_42120, _28484, [4]) ? creep
% Exit: (14) my_append([], [4], [4]) ? creep
% Exit: (13) my_append([5], [4], [5, 4]) ? creep
% Call: (13) [5]\=[] ? creep
% Exit: (13) [5]\=[] ? creep
% Call: (13) [4]\=[] ? creep
% Exit: (13) [4]\=[] ? creep
% Exit: (12) split([3, 5, 4], [3], [5], [4]) ? creep
% A = [3],
% B = [5],
% C = [4] .

% is an integer, pass.
check_len(Len) :-
    integer(Len), 
    Len >= 0.

% Otherwise, not an integer.
check_len(_) :-
    print("SPLIT3/2: The first argument must be a positive integer and must be defined."), 
    !, fail.

% An empty list is not valid, since there is nothing to split.
check_list([]).
% Lists are able to unify with [_|_]
check_list([_|_]).
% Otherwise, they're not a list.
check_list(_) :-
    print("SPLIT3/2: The second argument must be a list."), 
    !, fail.
