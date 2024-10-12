; 5 gallon, 3 gallon
; Goal is to get 4 gallons
; Invalid moves:
; - Negative number
; - Over 5 or over 3
; Must pour all, cannot pour half
; - Fill 5 gallon
; - Fill 3 gallon
; - Pour 3 gallon into 5 gallon
; - Drain any amount of gallons

; https://sac.edu/AcademicProgs/ScienceMathHealth/Mathematics/Documents/4%20gallons%20in%20a%205%20gallon%20jug%20solution.pdf
; https://www.reddit.com/r/math/comments/38zemn/solving_the_puzzle_from_die_hard_fill_exactly_4/
; Generally, these problems are trivial. Just make jug A the larger one, and follow this procedure:
; - Fill jug A
; - If the total amount in both jugs is the target, then stop.
; - Pour as much as you can from Jug A into Jug B.
; - If Jug B is full, empty it and go back to step 2.
; - Goto 1.
; This will work for any target quantity so long as target < A + B and target is a multiple of GCD(A,B). 
; It's based on Bézout's identity, which says that for any integral A and B, there exist integers x and y such that A*x + B*y = GCD(A,B).
; There will always be a solution with positive x and negative y, which corresponds to filling jug A x times and emptying jug B y times.
;  (< (nth 0 *goals*) (+ (nth 0 state) (nth 1 state))) ; target < A + B

; https://favtutor.com/blogs/water-jug-problem
; The following operations can be performed on the jugs:
; Empty a jug (a, b) -> (0, b)
; Fill a jug (0, b) -> (a, b)
; Transfer water from one jug to another.

; State = (5GAL 3GAL)
(defun wj-valid (state)
  (cond
   ((and
     (>= (nth 0 state) 0) ; Gallons cannot be negative
     (>= (nth 1 state) 0)
     (<= (nth 0 state) 5) ; 5 gallon bucket cannot fill > 5
     (<= (nth 1 state) 3) ; 3 gallon bucket cannot fill > 3
     ) state)
   (T nil)))

; fill 5 gallon jug
(defun wj-f5 (state)
  (cond
   ((eq (nth 0 state) 5) nil)
   (T (wj-valid
        (list
         (+ (nth 0 state) (- 5 (nth 0 state)))
         (nth 1 state))) ; (+ X (- 5 X)) get difference, then add to fill.
      )))

; fill 3 gallon jug
(defun wj-f3 (state)
  (cond
   ((eq (nth 0 state) 3) nil)
   (T (wj-valid
        (list
         (nth 0 state)
         (+ (nth 1 state) (- 3 (nth 1 state))))) ; (+ X (- 3 X)) get difference, then add to fill.
      )))

(defun wj-e5 (state)
  (cond
   ((eq (nth 0 state) 0) nil) ; can't empty an already empty bucket
   (T (wj-valid
        (list 0 (nth 1 state)) ; empty 5 gallon bucket
        ))))

(defun wj-e3 (state)
  (cond
   ((eq (nth 1 state) 0) nil) ; can't empty an already empty bucket
   (T (wj-valid
        (list (nth 0 state) 0) ; empty 3 gallon bucket
        ))))

; assume 2 gal, so fill 1 gal
; (+ 2 (- 3 2)) = (+ 2 1) = 3
; figure out if 5 gal bucket can fill 1 gal
; (5 gal amount held) > (gals needed to fill 3 gal)
; 1 gall needed to fill < amount held in 5 gal, then fail

; 5 gallon bucket has 5 gallons
; 3 gallon bucket has 0 gallons
; wj-5to3 will take (current 5g gallons) - (3 - (current 3g gallons)) 
; = 5 - (3 - 0) = 2, so 5 gallon bucket has 2 gallons left, 3g has 3 gallons now.
; to get amount in 3 gallons, how much can 5 give me?
; (2 3)
; 5g has 3
; 3g has 1
; = 3 - (3 - 1) = 1 in 5g

; use 5 gallon bucket to fill 3 gallon bucket
(defun wj-5to3 (state)
  (cond
   ((eq (nth 0 state) 0) nil) ; check if 5 gallon bucket has enough to fill 3 gallon bucket 
   ((eq (nth 1 state) 3) nil) ; check if 3 gallon bucket is already full
   ; 5gal has spare gallons
   ((>= (- (nth 0 state) (- 3 (nth 1 state))) 0)
     (wj-valid
       (list
        (- (nth 0 state) (- 3 (nth 1 state)))
        (+ (nth 1 state) (- 3 (nth 1 state))))))
   ; 5g spent all gallons
   ((< (- (nth 0 state) (- 3 (nth 1 state))) 0)
     (wj-valid
       (list
        0
        (+ (nth 0 state) (nth 1 state)))))
   (T nil)))

; input (5 2)
; expect (4 3)
; (- 5 (- 3 2))
; (- 5 1)
; 4
; (+ 2 (- 3 2))
; (+ 2 1)
; 3

; (wj-5to3 '(5 0)) ; Expected output: (2 3)
; (wj-5to3 '(5 2)) ; Expected output: (4 3)
; (wj-5to3 '(2 1)) ; Expected output: (0 3)
; (wj-5to3 '(1 1)) ; Expected output: (0 2)
; (wj-5to3 '(0 3)) ; Expected output: nil

; input: (4 3)
; expect: (5 2)
; (- 3 (- 5 4))
; (- 3 1)
; 2
; (+ (- 5 4) 3)
; (+ 1 3)
; 4 wrong ):
; (+ (- 5 4) 4)
; (+ 1 4)

; use 3 gallon bucket to fill 5 gallon bucket
(defun wj-3to5 (state)
  (cond
   ((eq (nth 0 state) 5) nil) ; 5 gallon bucket is already full
   ((eq (nth 1 state) 0) nil) ; 3 gallon bucket is empty
   ; 3gal has spare gallons
   ((>= (- (nth 1 state) (- 5 (nth 0 state))) 0)
     (wj-valid
       (list
        (+ (nth 0 state) (- 5 (nth 0 state)))
        (- (nth 1 state) (- 5 (nth 0 state))))))
   ; 3g spent all gallons
   ((< (- (nth 1 state) (- 5 (nth 0 state))) 0)
     (wj-valid
       (list
        (+ (nth 0 state) (nth 1 state))
        0)))
   (T nil)))

; (wj-3to5 '(5 0)) ; Expected output: nil
; (wj-3to5 '(4 3)) ; Expected output: (5 2)
; (wj-3to5 '(2 1)) ; Expected output: (3 0)
; (wj-3to5 '(0 3)) ; Expected output: (3 0)
; (wj-3to5 '(1 1)) ; Expected output: (2 0)

; heuristic method
; want 5-gal jug to be at 5.
; lower heuristic number = better
(defun wj-h (state)
  (cond
   ((eq (first state) 5) 1) ; at 5 gallons. 
   (T (- 4 (first state))))) ; distance to 4 gallons in 5g bucket

(defparameter *start* '(0 0))
(defparameter *goals* '(4 0))
(defparameter *moves* (list #'wj-f5 #'wj-f3 #'wj-e5 #'wj-e3 #'wj-5to3 #'wj-3to5))
(defparameter *h* #'wj-h)
