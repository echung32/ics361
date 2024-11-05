% count/3 -> color, list, occurances
count(_, [], 0).

% Symbol == Color, increment.
count(Color, [Color | Rest], Occur) :-
    count(Color, Rest, SOccur),
    Occur is SOccur + 1.

% Symbol not matching, continue.
count(Color, [_ | Rest], Occur) :-
    count(Color, Rest, Occur).


% ----- SITUATION 1 -----
% You have 20 colored balls. 
% 19 are white, one is red.
sit1(X) :-
    X = [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
    count(white, X, 19),
    count(red, X, 1).

% ----- SITUATION 2 -----
% You have six colored balls: two orange, two white and two black.
% No balls of the same color may be adjacent to one another.

sit2(X) :-
    X = [_, _, _, _, _, _],
    count(orange, X, 2),
    count(white, X, 2),
    count(black, X, 2),
    no_adjacent(X).

% -- no_adjacent/1 -> list
no_adjacent([]).

% Adjacent element found, block backtracking and fail.
no_adjacent([C, C | _]) :-
    !, fail.

% No adjacent element found, continue on.
no_adjacent([_ | Rest]) :-
    no_adjacent(Rest).

% ----- SITUATION 3 -----
% You have six colored balls: four green, one pink and one red.
% There are no more than two green balls in a row.

sit3(X) :-
    X = [_, _, _, _, _, _],
    count(green, X, 4),
    count(pink, X, 1),
    count(red, X, 1),
    max_two_adjacent(X).

% -- max_two_adjacent/2 -> list
max_two_adjacent([]).

% 3 adjacent elements found, block backtracking and fail.
max_two_adjacent([C, C, C | _]) :-
    !, fail.

% No adjacent element found, continue on.
max_two_adjacent([_ | Rest]) :-
    max_two_adjacent(Rest).

% ----- SITUATION 4 -----
% You have eight colored balls: one purple, two red, two white, and three silver.
% The balls in positions 2 and 3 are not silver.
% The balls in positions 4 and 8 are the same color.
% The balls in positions 1 and 7 are of different colors.
% There is a silver ball to the left of every white ball.
% A red ball is neither first nor last.
% The balls in positions 6 and 7 are not white.

sit4(X) :-
    X = [_, _, _, _, _, _, _, _],
    count(purple, X, 1),
    count(red, X, 2),
    count(white, X, 2),
    count(silver, X, 3),
    % Position - 1 because zero-indexed
    block_position(silver, X, 1),
    block_position(silver, X, 2),
    same_color(X, 3, 7),
    \+ same_color(X, 0, 6),
    match_to_left(X, silver, white),
    block_position(red, X, 0),
    block_position(red, X, 7),
    block_position(white, X, 5),
    block_position(white, X, 6).

% -- block_position/3 -> color, list, position to block
block_position(_, [], _).

% Same color matched, and blocked position as current matched.
block_position(Color, [Color | _], 0) :-
    !, fail.

% Not the same, so okay to pass.
% Skip rest of the list, if not already at the end.
block_position(_, _, 0) :-
    !. % stop backtracking. without this, keeps checking duplicates.

% Color is not the same, decrease blocked position
% This makes it so, once BlockedPosition reaches 0,
% that is the position to check whether they are equal.
block_position(Color, [_ | Rest], BlockedPosition) :-
    NBlockedPosition is BlockedPosition - 1,
    block_position(Color, Rest, NBlockedPosition).

% -- same_color/3 -> list, pos1, pos2
% checks whether the elements at pos1 and pos2 are the same
same_color(X, Pos1, Pos2) :-
    my_nth(Pos1, X, Ele1),
    my_nth(Pos2, X, Ele2),
    Ele1 == Ele2.

% -- my_nth/3 -> position, list, element
my_nth(_, [], _).

% at 0th position, color is unified with element
my_nth(0, [Color | _], Color).

% continue until pos is 0.
my_nth(Pos, [_ | Rest], Element) :-
    NPos is Pos - 1,
    my_nth(NPos, Rest, Element).

% -- match_to_left -> list, color1, color2
% color1 must always be to the left of color2.
match_to_left([], _, _).
% they are adjacent, which is good.
% but continue searching the rest of the list now.
match_to_left([Color1, Color2 | Rest], Color1, Color2) :-
    match_to_left(Rest, Color1, Color2).
% case when color2 is at the start
% which means nothing on the left.
match_to_left([Color2 | _], _, Color2) :-
    !, fail.
% not adjacent, fail immediately.
match_to_left([_, Color2 | _], _, Color2) :-
    !, fail.
% not found valid adjacent. continue.
match_to_left([_ | Rest], Color1, Color2) :-
    match_to_left(Rest, Color1, Color2).