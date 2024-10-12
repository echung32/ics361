; https://www.d.umn.edu/~jrichar4/8puz.html
; C++ algorithm https://github.com/faizan1234567/8-Puzzle-A-Star-Search 
; uses both hamming and manhatten distance heuristics

; first heuristic: check tiles out of place
(defun 8tp-h1 (state)
  (8tp-h1-recur state *goals* 0))

; recursive method to check each slot out of place
(defun 8tp-h1-recur (state goals count)
  (cond
   ((null state) count) ; state empty, checked all slots.
   ((null goals) count) ; redundant, but check goal also.
   ; state and goals are the same, don't add count.
   ((eq (first state) (first goals))
     (8tp-h1-recur (rest state) (rest goals) count))
   ; since state and goals are different, increment count.
   (T (8tp-h1-recur (rest state) (rest goals) (+ 1 count)))))

; second heuristic: use manhatten out of place distance 
; https://stackoverflow.com/questions/39759721/calculating-the-manhattan-distance-in-the-eight-puzzle
; https://stackoverflow.com/questions/19770087/can-somebody-explain-in-manhattan-dstance-for-the-8-puzzle-in-java-for-me
(defun 8tp-h2 (state)
  (8tp-h2-recur state 0 0))

; recursive method to calculate sum of manhattan distance
(defun 8tp-h2-recur (state index sum)
  (cond
   ; finished going through elements, return manhattan distance.
   ((null state) sum)
   ; skip manhattan distance for element 0
   ((eq (first state) 0)
     (8tp-h2-recur (rest state) (+ 1 index) sum)) ; move on to next index.
   (T (8tp-h2-recur
        (rest state)
        (+ 1 index)
        ; Sum of manhattan distance
        ; 3 represents dimension of the puzzle (3x3), but we are in a 1d form.
        ; Manhatten Distance = |currentRow - targetRow| + |currentCol - targetCol|
        (+ sum
           (+ (abs
                (-
                 (floor (/ index 3))
                 (floor (/ (- (first state) 1) 3))))
              (abs
                (-
                 (mod index 3)
                 (mod (- (first state) 1) 3)))))))))

; make sure the state is still valid
; (defun 8tp-valid (state)
;   (cond
;    ((and
;      (eq (length state) 9))) ; make sure out length is still 9
;    ; make sure 1 of each from 0-8 exist in the list.
;    (T nil)))

; https://blog.goodaudience.com/solving-8-puzzle-using-a-algorithm-7b509c331288
; https://github.com/mahanthmukesh/8-puzzle-using-A-algorithm
; https://github.com/Mahendra-Maiti/8-puzzle-solver
; The empty space can only move in four directions
; 1. Up
; 2. Down
; 3. Right
; 4. Left

; move for going up.
(defun 8tp-up (state)
  (cond
   ; index cannot be one of (0 1 2), means already at top.
   ((member (find-0th-index state) '(0 1 2)) nil)
   ((eq (find-0th-index state) 3) (list (nth 3 state) (nth 1 state) (nth 2 state)
                                        (nth 0 state) (nth 4 state) (nth 5 state)
                                        (nth 6 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 4) (list (nth 0 state) (nth 4 state) (nth 2 state)
                                        (nth 3 state) (nth 1 state) (nth 5 state)
                                        (nth 6 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 5) (list (nth 0 state) (nth 1 state) (nth 5 state)
                                        (nth 3 state) (nth 4 state) (nth 2 state)
                                        (nth 6 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 6) (list (nth 0 state) (nth 1 state) (nth 2 state)
                                        (nth 6 state) (nth 4 state) (nth 5 state)
                                        (nth 3 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 7) (list (nth 0 state) (nth 1 state) (nth 2 state)
                                        (nth 3 state) (nth 7 state) (nth 5 state)
                                        (nth 6 state) (nth 4 state) (nth 8 state)))
   ((eq (find-0th-index state) 8) (list (nth 0 state) (nth 1 state) (nth 2 state)
                                        (nth 3 state) (nth 4 state) (nth 8 state)
                                        (nth 6 state) (nth 7 state) (nth 5 state)))
   (T nil)))

; move for going up.
(defun 8tp-down (state)
  (cond
   ; index cannot be one of (6 7 8). can't go down any further.
   ((member (find-0th-index state) '(6 7 8)) nil)
   ((eq (find-0th-index state) 0) (list (nth 3 state) (nth 1 state) (nth 2 state)
                                        (nth 0 state) (nth 4 state) (nth 5 state)
                                        (nth 6 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 1) (list (nth 0 state) (nth 4 state) (nth 2 state)
                                        (nth 3 state) (nth 1 state) (nth 5 state)
                                        (nth 6 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 2) (list (nth 0 state) (nth 1 state) (nth 5 state)
                                        (nth 3 state) (nth 4 state) (nth 2 state)
                                        (nth 6 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 3) (list (nth 0 state) (nth 1 state) (nth 2 state)
                                        (nth 6 state) (nth 4 state) (nth 5 state)
                                        (nth 3 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 4) (list (nth 0 state) (nth 1 state) (nth 2 state)
                                        (nth 3 state) (nth 7 state) (nth 5 state)
                                        (nth 6 state) (nth 4 state) (nth 8 state)))
   ((eq (find-0th-index state) 5) (list (nth 0 state) (nth 1 state) (nth 2 state)
                                        (nth 3 state) (nth 4 state) (nth 8 state)
                                        (nth 6 state) (nth 7 state) (nth 5 state)))
   (T nil)))

(defun 8tp-left (state)
  (cond
   ; index cannot be one of (0 3 6). can't move left any further.
   ((member (find-0th-index state) '(0 3 6)) nil)
   ((eq (find-0th-index state) 1) (list (nth 1 state) (nth 0 state) (nth 2 state)
                                        (nth 3 state) (nth 4 state) (nth 5 state)
                                        (nth 6 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 2) (list (nth 0 state) (nth 2 state) (nth 1 state)
                                        (nth 3 state) (nth 4 state) (nth 5 state)
                                        (nth 6 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 4) (list (nth 0 state) (nth 1 state) (nth 2 state)
                                        (nth 4 state) (nth 3 state) (nth 5 state)
                                        (nth 6 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 5) (list (nth 0 state) (nth 1 state) (nth 2 state)
                                        (nth 3 state) (nth 5 state) (nth 4 state)
                                        (nth 6 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 7) (list (nth 0 state) (nth 1 state) (nth 2 state)
                                        (nth 3 state) (nth 4 state) (nth 5 state)
                                        (nth 7 state) (nth 6 state) (nth 8 state)))
   ((eq (find-0th-index state) 8) (list (nth 0 state) (nth 1 state) (nth 2 state)
                                        (nth 3 state) (nth 4 state) (nth 5 state)
                                        (nth 6 state) (nth 8 state) (nth 7 state)))
   (T nil)))

(defun 8tp-right (state)
  (cond
   ; index cannot be one of (2 5 8). empty tile can't go right any further.
   ((member (find-0th-index state) '(2 5 8)) nil)
   ((eq (find-0th-index state) 0) (list (nth 1 state) (nth 0 state) (nth 2 state)
                                        (nth 3 state) (nth 4 state) (nth 5 state)
                                        (nth 6 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 1) (list (nth 0 state) (nth 2 state) (nth 1 state)
                                        (nth 3 state) (nth 4 state) (nth 5 state)
                                        (nth 6 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 3) (list (nth 0 state) (nth 1 state) (nth 2 state)
                                        (nth 4 state) (nth 3 state) (nth 5 state)
                                        (nth 6 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 4) (list (nth 0 state) (nth 1 state) (nth 2 state)
                                        (nth 3 state) (nth 5 state) (nth 4 state)
                                        (nth 6 state) (nth 7 state) (nth 8 state)))
   ((eq (find-0th-index state) 6) (list (nth 0 state) (nth 1 state) (nth 2 state)
                                        (nth 3 state) (nth 4 state) (nth 5 state)
                                        (nth 7 state) (nth 6 state) (nth 8 state)))
   ((eq (find-0th-index state) 7) (list (nth 0 state) (nth 1 state) (nth 2 state)
                                        (nth 3 state) (nth 4 state) (nth 5 state)
                                        (nth 6 state) (nth 8 state) (nth 7 state)))
   (T nil)))

; find the index of 0
(defun find-0th-index (state)
  (find-0th-index-recur state 0))
; will have to check for -1 case in recursion loop to set index properly.
; don't think this is necessary, as long as we validate 0 exists after state changes.
;   (cond
;    ((eq (find-0th-index-recur state -1) -1) (print "should not be nil!") nil)
;    (T (find-0th-index-recur state -1))))

; helper method to do the recursion process.
(defun find-0th-index-recur (state index)
  (cond
   ; base case: found 0's index, return index.
   ((eq (first state) 0) index)
   ; keep going through state to find the index.
   (T (find-0th-index-recur (rest state) (+ 1 index)))))

(defparameter *startA* '(1 2 3 4 8 5 7 0 6))
(defparameter *startB* '(8 6 3 2 1 4 7 5 0))
(defparameter *startC* '(1 2 3 4 5 6 0 7 8))
(defparameter *goals* '(1 2 3 4 5 6 7 8 0))
(defparameter *moves* (list #'8tp-up #'8tp-down #'8tp-right #'8tp-left))
(defparameter *h1* #'8tp-h1)
(defparameter *h2* #'8tp-h2)

; (8tp-h2 '(1 2 3 4 5 6 7 8 0)) = 0
; (8tp-h2 '(1 2 3 4 5 6 7 0 8)) = 1
; (8tp-h2 '(8 7 6 5 4 3 2 1 0)) = 16
; (8tp-h2 '(2 8 3 1 6 4 7 0 5)) = 9

; Verifying with formula from https://stackoverflow.com/questions/39759721/calculating-the-manhattan-distance-in-the-eight-puzzle
; >>> board = [1, 2, 3, 4, 5, 6, 7, 0, 8]
; ... sum(abs((val-1)%3 - i%3) + abs((val-1)//3 - i//3)
; ...         for i, val in enumerate(board) if val)
; ...         
; 1
; >>> board = [8,7,6,5,4,3,2,1,0]
; ... sum(abs((val-1)%3 - i%3) + abs((val-1)//3 - i//3)
; ...         for i, val in enumerate(board) if val)
; ...         
; 16
; >>> board = [2,8,3,1,6,4,7,0,5]
; ... sum(abs((val-1)%3 - i%3) + abs((val-1)//3 - i//3)
; ...         for i, val in enumerate(board) if val)
; ...         
; 9