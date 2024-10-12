/* FACTORIALKB/2
Second argument is the factorial of the first. Compare with the other version (in Factorial.pl). Do they behave differently when arguments are instantiated or unintantiated, or when you force them to backtrack (by hitting ";")? Is one more efficient than the other? Why or why not? 
*/

factorialKB(X,Y):-
	factorial3arg(X,1,Y).

/* FACTORIAL3ARG/3
Tail-recursive version of factorial. Call with the second argument set to 1. 
Use "trace." to understand why!
*/
	
/* Base case first. */

factorial3arg(0,F,F).

/* Then recurse. */

factorial3arg(N,A,F):-
	N > 0,
	A1 is N*A,
	N1 is N-1,
	factorial3arg(N1,A1,F).