# ICS 361 Assignment 3: State Space Representations and Informed Search

Your task here is to implement a general-purpose (i.e. not puzzle-specific) version of the A* search strategy, and apply it to three different puzzles. Create meaningful comments in all files with a description of the problem and descriptions of each of the variables and functions used in the file. You can start with existing code or strategies you find online, but you must cite your source, indicate clearly which code is yours and which is from someone else, and write all of the comments in your own words. I recommend NOT using code found online (except as inspiration), as it is unlikely to meet the requirements of this assignment without significant modification. In particular, you must implement the search strategies functionally and recursively, without the use of global variables (global constants are acceptable, to save on typing). 

## Part A (10 points)

Implement heuristic search (A*). Your search code must be independent of the application problem (i.e. you should use the same search code for all three games). You should have printing functions so that the first node on the open list is printed at each step. You should also have printing functions so that when the goal is reached, the solution path and the lengths of the open and closed lists are printed.

If you completed Assignment 2 successfully, most of this is already done! All you have to do is:

- Adapt your search function to take the name of a heuristic function h(n) as an argument
- Use the ordering function f(n) to sort the open list. [remember, f(n) = g(n) + h(n)]

## Part B (30 points)

In Assignment 2, you (hopefully!) created a state representation and moves for the Missionaries and Cannibals problem. Now, create state representations and moves for these problems. Demonstrate that they work with DFS/BFS.

- (15 points) Water Jugs https://www.popularmechanics.com/science/math/a24463/riddle-of-the-week-8/
- (15 points) The 8-Tile Puzzle https://www.tilepuzzles.com/default.asp?p=1 [Here, you'll have to demonstrate with a start state very close to the goal state. Otherwise, uninformed search will take a LONG time to complete!]
 

## Part C (30 points)

For both the Missionaries & Cannibals problem and the Water Jugs problem, implement an ordering function f(n) which includes a heuristic function h(n) that estimates the distance between two states (i.e. the current state and the goal state). Hint: counting/measuring the "items out of place" is a good place to start!

Then, run A* and compare it to uninformed search. Did your heuristics improve the search (i.e. reduce the number of nodes searched) at all? If so, why? If not, why not? Note: If the heuristics didn't help, that's fine - but you need to explain why!

## Part D (30 points)

For the 8-puzzle:

- (15 points) Implement the tiles out of place heuristic, and provide a transcript of its performance on the following two states: 
```
1 2 3
4 8 5
7    6

8 6 3
2 1 4
7 5 
```

- (15 points) Implement the Manhattan distance out-of-place heuristic, and provide transcripts of its performance on the two states above. How does it compare with the tiles out of place heuristic? Is it more informed ? Why or why not (based on performance, as opposed to reasoning)?
Note: If the search fails to complete (e.g. runs out of memory, is still running after 30min or so), say so! How many nodes had it searched when it died or you gave up? 
