% at least 1 of each dog, cat

pets(List, Length) :-
    % prevent list length from going beyond length
    % otherwise it infinitely increases the length
    length(List, Length),
    member(X, List),
    dog(X),
    member(Y, List),
    cat(Y).

dog(cosmo).
dog(brutus).
cat(fluffy).
cat(cheeto).

% negative tests may make things easier
% there does not exist a dog without a tail
% every dog has a tail

% syntactic sugar
% when you have a programming language with a simple syntax, but we need some conveniences sometimes
% not necessary to the language, but makes your life a lot nicer.
% i.e. in Lisp, like '() instead of (QUOTE ()) 