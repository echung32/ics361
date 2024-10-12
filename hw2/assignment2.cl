; Example code (no closed list) https://www-users.cselabs.umn.edu/classes/Spring-2019/csci4511/lisp/df.html
; Explanation of the algorithm https://www.cs.columbia.edu/~jvoris/AI/notes/search-basic.html
; purpose of open and closed list https://stackoverflow.com/questions/27063959/depth-first-search-open-and-closed-list

; node is the current state + paths + cost

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
     (bfs (rest open-list) closed-list goals moves))
   ; check whether the first open node is already in the rest of the open list. skip it.
   ((mymember (first open-list) (rest open-list))
     ;  (format t "Skipped first node in open (duplicated open): ~a.~%" (first open-list))
     (bfs (rest open-list) closed-list goals moves))
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

; https://www.khoury.northeastern.edu/home/rjw/csg120/programs/search/a-star.lisp
; f(n) = h(n) + g(n)
; where h(n) = estimate from n to goal
;       g(n) = depth at which n is found
; start the recursive process for a-star-search
(defun a-star-search (start goals moves h)
  (cond
   ((null start) (print "start node empty") nil) ; check defined start
   ((null goals) (print "goals node empty") nil) ; check defined goal
   ((null moves) (print "moves node empty") nil) ; check defined moves
   (T (a-star (list (list start '())) '() goals moves h)))) ; start recursive process

(defun a-star (open-list closed-list goals moves h)
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
     (a-star (rest open-list) closed-list goals moves h))
   ; check whether the first open node is already in the rest of the open list. skip it.
   ((mymember (first open-list) (rest open-list))
     ;  (format t "Skipped first node in open (duplicated open): ~a.~%" (first open-list))
     (a-star (rest open-list) closed-list goals moves h))
   ; the open-list is updated to have the new childrens that are not already in the open-list or closed-list.
   (T
     (format t "First node on open list: ~a.~%" (first open-list))
     (a-star
       ; append children to start of open list (or end, doesn't matter)
       ; then run sort using the heuristic function h
       (sort-by-heuristic
         h
         (append
           (generate-children (first open-list) moves)
           (rest open-list)))
       (cons (first open-list) closed-list) ; move first open node into closed
       goals moves h))))

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
        (generate-children node (rest moves)))))) ; keep first fn, continue with rest

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

; method to help start recursion process to sort list.
(defun sort-by-heuristic (h ulist)
  (cond
   ((null ulist) nil) ; list provided was empty. nothing to sort!
   (T (h-merge-sort h ulist)))) ; call helper method to do recursion.

; recursive method to sort list
; returns the sorted list at the end.
; utilize recursive merge sort
; https://www.geeksforgeeks.org/merge-sort/
; https://gist.github.com/cleac/4355da18f88ae4f53e5cb1fab18839f5
; https://literateprograms.org/merge_sort__lisp_.html
(defun h-merge-sort (h ulist)
  (cond
   ((<= (length ulist) 1) ulist) ; stop when list length <= 1, means we return it as-is.
   (T (h-merge
        h ; heuristic function :)
        (h-merge-sort h (my-subseq ulist 0 (ceiling (length ulist) 2))) ; call on first half of list
        (h-merge-sort h (my-subseq ulist (ceiling (length ulist) 2) (length ulist))))))) ; call on second half of list

; first half of the list, second half of the list.
(defun h-merge (h fst snd)
  (cond
   ((null fst) snd) ; first is empty, go second half
   ((null snd) fst) ; second is empty, go first half
   ; heuristic of fst < snd
   ((< (f-n h (first fst)) (f-n h (first snd)))
     (append (list (first fst)) (h-merge h (rest fst) snd))) ; append list with fst in front 
   ; heuristic of fst > snd
   ((> (f-n h (first fst)) (f-n h (first snd)))
     (append (list (first snd)) (h-merge h fst (rest snd)))) ; append list with snd in front
   ; heuristic of fst = snd
   ((= (f-n h (first fst)) (f-n h (first snd)))
     (append (list (first fst)) (list (first snd)) (h-merge h (rest fst) (rest snd)))) ; append list with fst, snd, in front
   (T nil))) ; shouldn't get to here

; calculate f(n)
(defun f-n (h node)
  (cond
   ((null node) nil)
   (T (+
       (funcall h (first node)) ; h(n) - estimate to goal
       (length (second node)))))) ; g(n) - length of path

; https://jtra.cz/stuff/lisp/sclr/subseq.html
; creates a new list from start/end of list.
(defun my-subseq (lst start end)
  (my-subseq-helper lst start end 0 '()))

(defun my-subseq-helper (lst start end curr sublst)
  (cond
   ((>= curr end) (reverse sublst)) ; curr >= end, finished.
   ((null lst) nil) ; is empty or has become empty. could be b/c start > end
   ((< curr start) (my-subseq-helper (rest lst) start end (+ 1 curr) sublst)) ; skip list until we reach start
   (T (my-subseq-helper (rest lst) start end (+ 1 curr) (cons (first lst) sublst))))) ; add element into sublst
