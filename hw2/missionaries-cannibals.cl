; https://chatgpt.com/share/66f0b4d5-2bac-8011-b75c-d12c7e2bda6b
; https://en.wikipedia.org/wiki/Missionaries_and_cannibals_problem
; Lisp https://www.reddit.com/r/RacketHomeworks/comments/10h41km/solving_the_problem_of_missionaries_and_cannibals/
; Prolog https://github.com/marianafranco/missionaries-and-cannibals/blob/master/prolog/missionaries_and_cannibals.pl

; state = (C M D)
; C between 0, 3
; M between 0, 3
; D either W, E

; check that the move is valid
; this returns true or nil
(defun mc-valid (state)
  (and
   (>= (nth 0 state) 0) ; C >= 0
   (<= (nth 0 state) 3) ; C <= 3
   (>= (nth 1 state) 0) ; M >= 0
   (<= (nth 1 state) 3) ; M <= 3
   (or ; M >= C or M = 0 on the west
      (>= (nth 1 state) (nth 0 state))
      (= (nth 1 state) 0)) ; M = 0
   (or ; M >= C or M = 0 on the east
      (>= (- 3 (nth 1 state)) (- 3 (nth 0 state)))
      (= (- 3 (nth 1 state)) 0))))

; move 1 cannibal
(defun mc-1c (state)
  (cond
   ((and (eq (nth 2 state) 'W) (mc-valid (list (- (nth 0 state) 1) (nth 1 state) 'E))) (list (- (nth 0 state) 1) (nth 1 state) 'E))
   ((and (eq (nth 2 state) 'E) (mc-valid (list (+ (nth 0 state) 1) (nth 1 state) 'W))) (list (+ (nth 0 state) 1) (nth 1 state) 'W))
   (T nil)))

; move 2 cannibal
(defun mc-2c (state)
  (cond
   ((and (eq (nth 2 state) 'W) (mc-valid (list (- (nth 0 state) 2) (nth 1 state) 'E))) (list (- (nth 0 state) 2) (nth 1 state) 'E))
   ((and (eq (nth 2 state) 'E) (mc-valid (list (+ (nth 0 state) 2) (nth 1 state) 'W))) (list (+ (nth 0 state) 2) (nth 1 state) 'W))
   (T nil)))

; move 1 missionary
(defun mc-1m (state)
  (cond
   ((and (eq (nth 2 state) 'W) (mc-valid (list (nth 0 state) (- (nth 1 state) 1) 'E))) (list (nth 0 state) (- (nth 1 state) 1) 'E))
   ((and (eq (nth 2 state) 'E) (mc-valid (list (nth 0 state) (+ (nth 1 state) 1) 'W))) (list (nth 0 state) (+ (nth 1 state) 1) 'W))
   (T nil)))

; move 2 missionary
(defun mc-2m (state)
  (cond
   ((and (eq (nth 2 state) 'W) (mc-valid (list (nth 0 state) (- (nth 1 state) 2) 'E))) (list (nth 0 state) (- (nth 1 state) 2) 'E))
   ((and (eq (nth 2 state) 'E) (mc-valid (list (nth 0 state) (+ (nth 1 state) 2) 'W))) (list (nth 0 state) (+ (nth 1 state) 2) 'W))
   (T nil)))

; move 1 missionary, 1 cannibal
(defun mc-1m1c (state)
  (cond
   ((and (eq (nth 2 state) 'W) (mc-valid (list (- (nth 0 state) 1) (- (nth 1 state) 1) 'E))) (list (- (nth 0 state) 1) (- (nth 1 state) 1) 'E))
   ((and (eq (nth 2 state) 'E) (mc-valid (list (+ (nth 0 state) 1) (+ (nth 1 state) 1) 'W))) (list (+ (nth 0 state) 1) (+ (nth 1 state) 1) 'W))
   (T nil)))

; heuristic function
; sum of missionaries and cannibals on the left bank
(defun mc-h (state)
  (cond
   ; on left (west) bank, sum the amounts.
   ((eq (nth 2 state) 'W) (+ (nth 0 state) (nth 1 state)))
   ; state is right (east) bank, calcualte amount from other side.
   ((eq (nth 2 state) 'E) (+ (- 3 (nth 0 state)) (- 3 (nth 1 state))))
   ; should not get to nil if state is valid!
   (T nil)))

(defparameter *start* '(3 3 W))
(defparameter *goals* '(0 0 E))
(defparameter *moves* (list #'mc-1c #'mc-2c #'mc-1m #'mc-2m #'mc-1m1c))
(defparameter *h* #'mc-h)