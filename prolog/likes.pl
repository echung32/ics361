% B implies A, A :- B.

% Some people know each other, some don't.
% knows(x, y) :- knows (y, x)

% people like things and/or people
% likes(x, y)

% people like themselves
% likes(x, x)

% if two people know each other and like the same person/thing, they like each other.
% likes(x, y) :-
%   knows(x, y),
%   likes(x, z),
%   likes(y, z)

knows(kim, cosmo).
knows(cosmo, kim).

knows(X, Y) :- knows(X, Y).

likes(kim, cosmo).
likes(cosmo, kim).
likes(kim, kim).

likes(X, X).

likes(X, Y) :-
    knows(X, Y),
    likes(X, Z),
    likes(Y, Z), 
    !.
