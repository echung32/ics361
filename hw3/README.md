## Prolog (100 points + 10 bonus points)

### Rules:
- Cite any sources you use (including other students). 
- Write your own code, comments, and error messages. 
- Do not use any built-in predicates (aside from arithmetic operators, PRINT/1 and FORMAT/2).

### A. (15 points) 

- Create a recursive Prolog predicate listlength/2 that has a list as its first argument, and the length of that list as its second argument. 

Examples:

```
?- listlength([9, 5, 6, 4],L).

L = 4.

?- listlength([], 0).

true.

?- listlength(List, 0).

List = [].

?- listlength([5, [6, 7, 8]], L).

L = 2.
```

- Make a transcript of your predicate working on five representative cases.

- What happens if you do this, and why?
```
?- listlength(L, 3).
```
- Hint: This might be useful for B…

### B. (60 points) 

- Write predicates that will find solutions for each of the following colored-balls-in-a-row problems with different sets of constraints. 

So, for example:
```
?- sit2(X).
X = [green, red, green, white, red, white] 
```
- Then, when your force backtracking (i.e. by hitting ";"), it should produce another valid solution, if any. When it has run out of solutions, it should fail.

- Hint: Try to think as declaratively as possible, and write a test predicate for each constraint type. For example: can you write a predicate COUNT/3 which has a symbol (e.g. white) as its first argument, a list as its second argument, and an integer (the number of times the symbol appears in the list) as its third argument? Could that be useful? 

#### Situation #1 (10 points)
```
You have 20 colored balls. 
19 are white, one is red.
Because this situation produces long lists, you might want to call it like this: sit1(X), print(X).
Situation #2 (15 points)
You have six colored balls: two orange, two white and two black.
No balls of the same color may be adjacent to one another.
Situation #3 (15 points)
You have six colored balls: four green, one pink and one red.
There are no more than two green balls in a row.
Situation #4 (20 points) 
You have eight colored balls: one purple, two red, two white, and three silver.
The balls in positions 2 and 3 are not silver.
The balls in positions 4 and 8 are the same color.
The balls in positions 1 and 7 are of different colors.
There is a silver ball to the left of every white ball.
A red ball is neither first nor last.
The balls in positions 6 and 7 are not white.
```
- Make a transcript of your code finding all solutions.

### C. (25 points)

- Write a predicate named split3(N,L) that has two arguments: N, a positive integer, and L, a list of positive integers. 
- You may assume that the list L is flat, i.e., it does not contain sublists, and that both N and L are instantiated (i.e. neither are variables).
- The predicate split3/2 returns true (or yes) if the list L can be partitioned into three sublists (with elements in the same order), such that the sum of the integers in each subset is less than or equal to N.
- Otherwise, it returns false (or no). 
- Each sublist must have at least one element.

- Again, thinking declaratively is key - although you might have to play with the order of the tests/constraints. 

Examples:
```
?-split3(5,[]).

false

?-split3(6,[5, 5, 12]).

false

?-split3(14,[6, 5, 10, 1, 1, 1, 14]).

true

?-split3(5,[3, 1, 4, 1, 2]).

true

?-split3(6,[4, 3, 5, 2, 1]).

false

?-split3(7,[4, 5, 7, 2, 3]).

false

?-split3(8,[3,5,4,2,7,1]).

true

?-split3(3,[1, 2, 2, 2, 1, 1]).

false
```
### D. (BONUS: 10 points) 
- Make your code print out informative errors (e.g. “LISTLENGTH/2: The first argument must be a list.”). 
- Make sure that this doesn’t affect how it works! You may use integer/1 for this part.