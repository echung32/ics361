## Part A (50 points)
Implement versions of both breadth-first and depth-first search strategies, using open and closed lists. Your search code must be independent of the application problem (i.e. you should use the same search code for both problems in Part B. You can start with existing code you find online, but you must cite your source, indicate clearly which code is yours and which is from someone else, and write all of the comments in your own words. I recommend NOT using existing code (except as inspiration), as it is unlikely to meet the requirements of this assignment without significant modification. In particular, you must implement the search strategies functionally and recursively, without the use of global variables (global constants such as *start*, *goals*, and *moves* are acceptable, to save on typing). Please also only use LISP functions described in class. This will reduce the likelihood of you programming in a non-functional manner.

Add printing functions to your searches so that the first node on the open list is printed in each iteration. Also add printing functions so that when the goal is reached, the length of the open and closed lists as well as the solution path is printed.

The attached transcript shows a depth-first search applied to the Missionaries and Cannibals river-crossing problem. Nodes (problem independent) are represented by a 2-tuple consisting of a state and the solution path from the start to that state. States (problem specific) are represented by a 3-tuple with the number of Cs then number of Ms on the start side and the 3rd part of the state shows the side where the boat is currently located. Both Ms and Cs can paddle the boat. The maximum capacity of the boat is two and the minimum is one (at least one M or C must be in the boat to paddle). The goal is to move all Ms and Cs to the opposite side while making sure that Cs do not outnumber Ms on either side of the river. If that should happen, Ms would be eaten (not a legal state).

## Part B (60 points)
Create representations (i.e. start state, goal state, and child-generating functions) of the Missionaries and Cannibals problem for use with the search strategies you implemented above.

Create meaningful comments in all files with a description of the problem and descriptions of each of the constants and functions used in the file. Load your code in to Lisp and save the output of solving the puzzle with both DFS and BFS. [UHUnixName]2OUT.txt (add A, B, C etc. if more than one file).

Note: you will use the code from this assignment for the next assignment.

## Hints:
- Write a recursive problem-independent function GENERATE-CHILDREN which takes a node and a list of moves as arguments, and returns a list of all the valid child nodes. Use FUNCALL to apply an item from the list of moves (e.g. 1-CANNIBAL-CROSSES) to the current state, returning a list of valid child states.
- Each move should be the name of a non-recursive problem-specific function.
- The top-level depth-first-search and breadth-first-search functions can be pretty basic, calling a helper function that actually implements the recursive algorithm.
- Note that the built-in MEMBER function doesn't work with a list as its first argument! So, you'll have to write a recursive MYMEMBER function that does.

## Turn in the following (all via Laulima):
- All code, appropriately commented.
- Transcripts of the solutions for each puzzle.

```
; Loading
;    C:\Users\kbins\Dropbox (HI-SEAS)\Kim Personal\Kim's Documents\UH Courses current\ICS 361 Spring 2021\LISP\Assignment 2\Assignment2.cl
CG-USER(1): 
; Loading
;    C:\Users\kbins\Dropbox (HI-SEAS)\Kim Personal\Kim's Documents\UH Courses current\ICS 361 Spring 2021\LISP\Assignment 2\missionaries-cannibals.cl
CG-USER(1): (depth-first-search *start* *goal* *moves*)
First node on open list: ((3 3 W) NIL).
First node on open list: ((2 3 E) ((3 3 W))).
First node on open list: ((3 3 W) ((2 3 E) (3 3 W))).
First node on open list: ((1 3 E) ((3 3 W))).
First node on open list: ((2 3 W) ((1 3 E) (3 3 W))).
First node on open list: ((1 3 E) ((2 3 W) (1 3 E) (3 3 W))).
First node on open list: ((0 3 E) ((2 3 W) (1 3 E) (3 3 W))).
First node on open list: ((1 3 W) ((0 3 E) (2 3 W) (1 3 E) (3 3 W))).
First node on open list: ((0 3 E) ((1 3 W) (0 3 E) (2 3 W) (1 3 E) (3 3 W))).
First node on open list: ((1 1 E) ((1 3 W) (0 3 E) (2 3 W) (1 3 E) (3 3 W))).
First node on open list: ((2 2 W) ((1 1 E) (1 3 W) (0 3 E) (2 3 W) (1 3 E) (3 3 W))).
First node on open list: ((1 1 E) ((2 2 W) (1 1 E) (1 3 W) (0 3 E) (2 3 W) (1 3 E) (3 3 W))).
First node on open list: ((2 0 E) ((2 2 W) (1 1 E) (1 3 W) (0 3 E) (2 3 W) (1 3 E) (3 3 W))).
First node on open list: ((3 0 W) ((2 0 E) (2 2 W) (1 1 E) (1 3 W) (0 3 E) (2 3 W) (1 3 E) (3 3 W))).
First node on open list: ((2 0 E) ((3 0 W) (2 0 E) (2 2 W) (1 1 E) (1 3 W) (0 3 E) (2 3 W) (1 3 E) (3 3 W))).
First node on open list: ((1 0 E) ((3 0 W) (2 0 E) (2 2 W) (1 1 E) (1 3 W) (0 3 E) (2 3 W) (1 3 E) (3 3 W))).
First node on open list: ((2 0 W) ((1 0 E) (3 0 W) (2 0 E) (2 2 W) (1 1 E) (1 3 W) (0 3 E) (2 3 W) (1 3 E) (3 3 W))).
First node on open list: ((1 0 E) ((2 0 W) (1 0 E) (3 0 W) (2 0 E) (2 2 W) (1 1 E) (1 3 W) (0 3 E) (2 3 W) (1 3 E) (3 3 W))).
First node on open list: ((0 0 E) ((2 0 W) (1 0 E) (3 0 W) (2 0 E) (2 2 W) (1 1 E) (1 3 W) (0 3 E) (2 3 W) (1 3 E) (3 3 W))).
Found goal: (0 0 E).
 Solution path: ((3 3 W) (1 3 E) (2 3 W) (0 3 E) (1 3 W) (1 1 E) (2 2 W) (2 0 E) (3 0 W) (1 0 E) (2 0 W) (0 0 E)).
 Length of open list: 9.
 Length of closed list: 12.
T
```