(DEFUN FACTORIAL(NUM)
  (COND
   ((EQ NUM 1) 1)
   (T (* NUM (FACTORIAL(1- NUM))))
   )
  )

;(DEFUN FILTER(IN)
;  (COND
;   ((NOT (LISTP IN)) (PRINT "not a list") NIL)
;   ((NULL IN) NIL)
;   ((NOT (NUMBERP(CAR IN))) (PRINT "not a number") NIL)
;   ((< (CAR IN) 0) (FILTER (CONS IN)))
;   (T (CONS (CDR IN) (FILTER (CONS IN))))
;   )
;  )

(DEFUN OCCUR(A B)
  (COND
   ((NOT (LISTP B)) (PRINT "l err") NIL)
   ((NULL B) 0)
   ((EQUAL A (CAR B)) (+ 1 (OCCUR A (CDR B))))
   ((LISTP (CAR B)) (+ (OCCUR A (CAR B)) (OCCUR A (CDR B))))
   (T (OCCUR A (CDR B)))
   )
  )


(DEFUN REV(A)
  (COND
   ((NOT (LISTP A)) (PRINT "l err") NIL)
   ((NULL A) NIL)
   (T (CONS (REV (REST A)) (LIST (CAR A))))
   )
  )

(DEFUN DOGMA(A)
  (COND
   ((NOT (LISTP A)) (PRINT "l err") NIL)
   ((NULL A) NIL)
   ((STRINGP (CAR A)) (FORMAT t "It is said that ~a.~%" (CAR A)) (DOGMA (CDR A)))
   ((LISTP (CAR A)) (DOGMA (CAR A)) (DOGMA (CDR A)))
   (T (DOGMA (CDR A)))
   )
  )

(DEFUN TOF(A)
  (COND
   ((NOT (LISTP A)) (PRINT "l err") NIL)
   ((NULL A) NIL)
   ((NULL (CAR A)) (- (TOF (CDR A)) 1))
   (T (+ (TOF (CDR A)) 1))
   )
  )

; ADD TO END
; A = list, B = item
(DEFUN A2E(A B)
  (COND
   ((NULL A) (LIST B))
   (T (CONS (CAR A) (A2E (CDR A) B)))
   )
  )
  