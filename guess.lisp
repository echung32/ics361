;; 1- and 1+ is the same as -- and ++ in other languages.
;; Meaning, it's just subtracting 1 or adding 1 to the result.

;; When a function is called, the last statement is used as a return value.
;; It may also result in the return value being printed to the terminal when the value is not being consumed.
;; i.e. in "(setf *big* (1- (guess-my-number)))", the value is consumed by this function call.
;; On the other hand, when called by itself at the end of the statement, the value is printed to terminal instead.

; define parameter small as 1
; this is used to keep track of the smallest possible guess number.
(defparameter *small* 1)
; define parameter big as 100
; this is used to keep track of the largest possible guess number.
(defparameter *big* 100)

; function guess-my-number
; arguments: none
; this function is called to start the guessing game.
; after the first call of this function, this is intended
;  to only be used by (smaller) and (bigger) functions.
(defun guess-my-number ()
     ; ash is the arithmetic shift operator, which shifts the result of (small + big) to the left (-1)
     (ash (+ *small* *big*) -1))

; function smaller
; arguments: none
; this function is called to lower the *big* global variable.
;  which changes the upper bounds of guess-my-number.
(defun smaller ()
     ; sets big to the result of (1 - result of calling guess-my-number)
     (setf *big* (1- (guess-my-number)))
     ; then, calls guess-my-number to continue the game.
     (guess-my-number))

; function bigger
; arguments: none
; this function is called to raise the *small* global variable,
;  which changes the lower bounds of guess-my-number.
(defun bigger ()
     ; sets small to the result of (1 + result of calling guess-my-number)
     (setf *small* (1+ (guess-my-number)))
     ; then, calls guess-my-number to continue the game.
     (guess-my-number))

; function start-over
; arguments: none
; this sets the variables back to their initial values, then restarts the guessing game.
(defun start-over ()
   ; sets small back to 1
   (setf *small* 1)
   ; sets big back to 100
   (setf *big* 100)
   ; then calls the guessing game method to start the game
  (guess-my-number))


