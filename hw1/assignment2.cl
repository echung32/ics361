; Example code (no closed list) https://www-users.cselabs.umn.edu/classes/Spring-2019/csci4511/lisp/df.html
; Explanation of the algorithm https://www.cs.columbia.edu/~jvoris/AI/notes/search-basic.html
; purpose of open and closed list https://stackoverflow.com/questions/27063959/depth-first-search-open-and-closed-list

; node is the current state + paths

; start the recursive process for breadth-first-search
(defun breadth-first-search (start goals moves)
  (cond
   ((null start) (print "start node empty") nil) ; check defined start
   ((null goals) (print "goals node empty") nil) ; check defined goal
   ((null moves) (print "moves node empty") nil) ; check defined moves
   (T (bfs (list (list start '())) '() goals moves)))) ; start recursive process

; helper method for bfs
(defun bfs (open-list closed-list goals moves)
  ; (format t "---~%Open:~%~a~%Closed:~%~a~%---" open-list closed-list)
  (cond
   ; open list is empty now, so no solution path was found :(
   ((null open-list) (print "no path found to solution") nil)
   ; check if first state on open list is goal state woohoo
   ((mymember goals (first open-list))
     (format t "Found goal: ~a~%" goals)
     (format t " Solution path: ~a~%" (reverse (append (list (first (first open-list))) (second (first open-list)))))
     (format t " Length of open list: ~a~%" (length open-list))
     (format t " Length of closed list: ~a~%" (length closed-list)) T)
   ; check whether the first open node's state is already in the closed list. skip it.
   ((mymember (first (first open-list)) closed-list)
     ;  (format t "Skipped first node in open (duplicated closed): ~a.~%" (first open-list)) 
     (dfs (rest open-list) closed-list goals moves))
   ; check whether the first open node is already in the rest of the open list. skip it.
   ((mymember (first open-list) (rest open-list))
     ;  (format t "Skipped first node in open (duplicated open): ~a.~%" (first open-list))
     (dfs (rest open-list) closed-list goals moves))
   ; the open-list is updated to have the new childrens that are not already in the open-list or closed-list.
   (T
     (format t "First node on open list: ~a.~%" (first open-list))
     (bfs
       ; breadth-first, so append children to end of list.
       (append
         (rest open-list)
         (generate-children (first open-list) moves))
       (cons (first open-list) closed-list) ; move first open node into closed
       goals moves))))

; start the recursive process for depth-first-search
(defun depth-first-search (start goals moves)
  (cond
   ((null start) (print "start node empty") nil) ; check defined start
   ((null goals) (print "goals node empty") nil) ; check defined goal
   ((null moves) (print "moves node empty") nil) ; check defined moves
   (T (dfs (list (list start '())) '() goals moves)))) ; start recursive process

; helper method for dfs
(defun dfs (open-list closed-list goals moves)
  ; (format t "---~%Open:~%~a~%Closed:~%~a~%---" open-list closed-list)
  (cond
   ; open list is empty now, so no solution path was found :(
   ((null open-list) (print "no path found to solution") nil)
   ; check if first state on open list is goal state woohoo
   ((mymember goals (first open-list))
     (format t "Found goal: ~a~%" goals)
     (format t " Solution path: ~a~%" (reverse (append (list (first (first open-list))) (second (first open-list)))))
     (format t " Length of open list: ~a~%" (length open-list))
     (format t " Length of closed list: ~a~%" (length closed-list)) T)
   ; check whether the first node's state is already in the closed list. skip it.
   ((mymember (first (first open-list)) closed-list)
     ;  (format t "Skipped first node in open (duplicated closed): ~a.~%" (first open-list)) 
     (dfs (rest open-list) closed-list goals moves))
   ; check whether the first open node is already in the rest of the open list. skip it.
   ((mymember (first open-list) (rest open-list))
     ;  (format t "Skipped first node in open (duplicated open): ~a.~%" (first open-list))
     (dfs (rest open-list) closed-list goals moves))
   ; the open-list is updated to have the new childrens that are not already in the open-list or closed-list.
   (T
     (format t "First node on open list: ~a.~%" (first open-list))
     (dfs
       ; depth-first, so append children to start of open list
       (append
         (generate-children (first open-list) moves)
         (rest open-list))
       (cons (first open-list) closed-list) ; move first open node into closed
       goals moves))))

; Takes a node and a list of move functions,
; and returns a list of valid child nodes.
(defun generate-children (node moves)
  (cond
   ((null node) nil) ; base case, no node provided.
   ((null moves) nil) ; base case, when moves is nil.
   ((null (funcall (first moves) (first node))) (generate-children node (rest moves))) ; discard first fn, continue with rest.
   (T (cons
        (list
         (funcall (first moves) (first node)) ; create a valid state node
         (cons (first node) (second node))) ; concat the state node into the prev paths
        (generate-children node (rest moves)))))) ; keep first fn, continue with rest.

; finds needle in any level of haystack
; took inspiration from count-occurances method
(defun mymember (needle haystack)
  (cond
   ((or (null needle) (null haystack)) nil) ; needle / haystack is empty
   ((equal needle (first haystack)) T) ; found needle in haystack
   ; needle matching in a deeper level
   ((listp (first haystack))
     (or (mymember needle (first haystack))
         (mymember needle (rest haystack))))
   (T (mymember needle (rest haystack))))) ; try searching in the rest of haystack

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

; (depth-first-search *start* *goals* *moves*)
; (breadth-first-search *start* *goals* *moves*)

; ; OPEN -- (3 3 W) should be skipped b/c it's already in CLOSED as (3 3 W)
; (defparameter *opene* '(((3 3 W) ((2 3 E) (3 3 W) (2 3 E) (3 3 W)))
;                         ((1 3 E) ((3 3 W) (2 3 E) (3 3 W))) ((2 2 E) ((3 3 W) (2 3 E) (3 3 W)))
;                         ((1 3 E) ((3 3 W))) ((2 2 E) ((3 3 W)))))

; ; CLOSED
; (defparameter *closede* '(((2 3 E) ((3 3 W) (2 3 E) (3 3 W))) ((3 3 W) ((2 3 E) (3 3 W)))
;                                                               ((2 3 E) ((3 3 W))) ((3 3 W) NIL)))

; (first (first *opene*))
; (mymember (first (first *opene*)) *closede*)