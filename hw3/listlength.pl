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
% cuts added to prevent backtracking for input handling
% i.e. check_len fails, check_list will also print failure
% even though it's perfectly valid. cut to prevent this.
% https://homepage.divms.uiowa.edu/~hzhang/c188/notes/ch08b-cut.pdf

listlength(List, Len) :-
    check_list(List), !,
    check_len(Len),
    listlength_helper(List, Len).

listlength_helper([], 0).
listlength_helper([_|Rem], Len) :-
    listlength_helper(Rem, Incr),
    Len is Incr + 1.

% is an integer, pass.
check_len(Len) :-
    integer(Len), !.

% not yet instantiated, pass.
check_len(Len) :-
    var(Len), !.

% Otherwise, not an integer.
check_len(_) :-
    print("LISTLENGTH/2: The second argument must be an integer."), 
    !, fail.

% An empty list is a valid list.
check_list([]).
% Lists are able to unify with [_|_]
check_list([_|_]).
% Otherwise, they're not a list.
check_list(_) :-
    print("LISTLENGTH/2: The first argument must be a list."), 
    !, fail.
