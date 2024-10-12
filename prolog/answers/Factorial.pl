/* FACTORIALKB/2 has an integer for its first argument. Its second argument is the factorial of the first. Call as (for example): factorialKB(6, X). */


/* Base case first. */

factorialKB(0,1).

/* Then recurse. Note: No error checking! */

factorialKB(N,Nfact):-
	Z is N-1, 		% A new variable Z is unified with N-1 (calculated)
	factorialKB(Z,Zfact),   % Recursion!
	Nfact is N * Zfact.     % Nfact is unified with N * Zfact


