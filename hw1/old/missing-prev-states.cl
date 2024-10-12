; Example code (no closed list) https://www-users.cselabs.umn.edu/classes/Spring-2019/csci4511/lisp/df.html
; Explanation of the algorithm https://www.cs.columbia.edu/~jvoris/AI/notes/search-basic.html
; wtf is open and closed list https://stackoverflow.com/questions/27063959/depth-first-search-open-and-closed-list

; node is the current state + paths

; start the recursive process for breadth-first-search
(defun breadth-first-search (start goals moves)
  (cond
   ((null start) (print "start node empty") nil) ; check defined start
   ((null goals) (print "goals node empty") nil) ; check defined goal
   ((null moves) (print "moves node empty") nil) ; check defined moves
   (T (bfs (list start '()) goals moves)))) ; start recursive process

; helper method for bfs
(defun bfs (start goals moves)
  ; stub
  (list start goals moves))

; start the recursive process for depth-first-search
(defun depth-first-search (start goals moves)
  (cond
   ((null start) (print "start node empty") nil) ; check defined start
   ((null goals) (print "goals node empty") nil) ; check defined goal
   ((null moves) (print "moves node empty") nil) ; check defined moves
   (T (dfs (list (list start '())) '() goals moves 0)))) ; start recursive process

; helper method for dfs
(defun dfs (open-list closed-list goals moves die)
  ; the current state + state path
  (format t "First node on open list: ~a.~%" (first open-list))
  (cond
   ((eq die 25) (print "stack overflow exception :(") nil)
   ; open list is empty now, so no solution path was found :(
   ((eq (length open-list) 0) (print "no path found to solution") nil)
   ; check if first state on open list is goal state woohoo
   ((eq (first (first open-list)) goals)
     (format t "Found goal: ~a~%" goals)
     (format t " Solution path: ~a~%" (reverse (second (first open-list))))
     (format t " Length of open list: ~a~%" (length open-list))
     (format t " Length of closed list: ~a~%" (length closed-list)))
   ; skip if first state on open list is already in closed
   ((mymember (first open-list) closed-list) (dfs (rest open-list) closed-list goals moves die))
   ; the open-list is updated to have the new childrens that are not already in the open-list or closed-list.
   (T (dfs
        (append
          (generate-children (first (first open-list)) moves)
          (rest open-list))
        (cons (first open-list) closed-list)
        goals moves (+ 1 die)))))

; Takes a state and a list of move functions,
; and returns a list of valid child states.
(defun generate-children (state moves)
  (cond
   ((null state) nil)
   ((null moves) nil)
   ((null (funcall (first moves) state)) (generate-children state (rest moves))) ; discard first fn, continue with rest.
   (T (cons
        (funcall (first moves) state)
        (generate-children state (rest moves)))))) ; keep first fn, continue with rest.

; checks if a children in children-list is already in check-list
; (defun filter-unique-children (children-list check-list)
;   (cond
;    ((null children-list) nil) ; finished recursion
;    ((mymember (first children-list) check-list)
;      (filter-unique-children (rest children-list) check-list)) ; skip first child, move on to next.
;    (T (cons
;         (first children-list)
;         (filter-unique-children (rest children-list) check-list)))) ; take first child, move on to next.
;   )

; finds list-a in any level of list-b
(defun mymember (list-a list-b)
  (cond
   ((or (null list-a) (null list-b)) nil) ; list-a / list-b is empty
   ((equal list-a (first list-b)) T) ; found list-a in list-b
   ; find matching in a deeper level
   ;  ((listp (first list-b))
   ;    (or (mymember list-a (first list-b))
   ;        (mymember list-a (rest list-b))))
   (T (mymember list-a (rest list-b))))) ; try searching in the rest of list-b

; Tests
; (eq '() '())
; (first '((1 2) (3 4)))
; (equal '(1 2) (first '((1 2) (3 4))))
; (equal '(1 2) (first '((2 1) (3 4))))
; (mymember '(1 2) '((3 4) (1 2)))
; (mymember '(1 2) '((3 4) (9 9)))

; the current state of the first node on the open list = (((3 3 W) NIL)))
; check the valid children for this node
; (generate-children (first '((3 3 W) NIL)) *moves*)
; result = (((2 3 E) ((3 3 W))) ((1 3 E) ((3 3 W))) ((2 2 E) ((3 3 W))))
; add to the front of the open list, but only if the state isn't in open or close lists.
; open list = (((3 3 W) NIL)))
; closed list = ()
; (mymember (generate-children (first '((3 3 W) NIL)) *moves*) '(((3 3 W) NIL)))
; nil

'(((2 0 W) (1 0 E) (3 0 W) (2 0 E) (2 2 W) (1 1 E) (1 3 W) (0 3 E) (2 3 W) (1 3 E) (3 3 W)) (0 0 E))