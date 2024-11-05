% https://stackoverflow.com/questions/38580501/prolog-if-a-float-is-input-output-prints-out-error

% -- ORIGINAL --
% listlength([], 0).

% listlength([_|Rem], Len) :-
%     listlength(Rem, Incr),
%     Len is Incr + 1.

% -- WITH INPUT VALIDATION --
% listlength(List, Len) :-
%     ( 
%         is_list(List)
%         ; print("LISTLENGTH/2: The first argument must be a list."), !, fail
%     ),
%     listlength_helper(List, Len).

% listlength_helper([], 0).

% listlength_helper([_|Rem], Len) :-
%     listlength(Rem, Incr),
%     Len is Incr + 1.

% - USING DISTINCT STATEMENTS
listlength(List, Len) :-
    check_list(List),
    listlength_helper(List, Len).

listlength_helper([], 0).
listlength_helper([_|Rem], Len) :-
    listlength_helper(Rem, Incr),
    Len is Incr + 1.

% An empty list is a valid list.
check_list([]).
% Lists are able to unify with [_|_]
check_list([_|_]).
% Otherwise, they're not a list.
check_list(_) :-
    print("LISTLENGTH/2: The first argument must be a list."), 
    !, fail.
