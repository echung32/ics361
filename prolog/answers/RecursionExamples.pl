/* ISMEMBER/2. Succeeds if ARG1 (an atom) is a member of ARG2 (a list). */

ismember(A, [A|_]). 

ismember(A, [_|T]) :- 
  ismember(A, T). 

/* LEN/2. Succeeds if ARG2 (an integer) is the length of ARG1 (a list) */

len([], 0).

len([_|R], N) :-
  len(R, N1),
  N is N1 + 1. 

/* SUMUP/2. ARG2 (integer) is the sum of ARG1 (list of integers). */

sumup([], 0). 

sumup([H|T], N):-
 sumup(T, N1),
 N is H + N1.
 
  

/* MYAPPEND/3. ARG3 is ARG1 and ARG2, appended. */

myappend([], L, L). 

myappend([H|T], A, [H|A1]):-
  myappend(T, A, A1). 


/* REVERSE1/2 ARG1 is a list. ARG1 is the reversed list. Here, we use myappend/3, defined above. However, this is not very efficient. Why? */

reverse1([A],[A]).

reverse1([H|T], RList) :-
  reverse1(T, Y),
  myappend(Y, [H], RList). 

/* REVERSELIST/2. ARG1 is a list. ARG1 is the reversed list. This approach is much more efficient, but a little harder to get your head around. */

reverselist(X, Y) :-
  reverse2(X, [], Y). 

reverse2([], Y, Y). 

reverse2([H|T], X, Y):-
  reverse2(T, [H|X], Y). 


/* APPEND3/3 

L is the lists A, B, and C appended, in that order. 

NOTE: Because Prolog uses depth first search (and is therefore not 100% declarative in action), the order of the MYAPPEND predicates here might be important, depending on what you're doing! 

*/
 
append3(L, A, B, C) :-
  myappend(A, B, X),
  myappend(X, C, L).



  
