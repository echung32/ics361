(DEFCONSTANT +us-currency+ "denominations in US currency"
    '((1000 10-dollar)(500 5-dollar)
    (100 dollar)(50 half-dollar)
     (25 quarter)(10 dime)
     (5 nickel)(1 penny))
)

(DEFUN MC(NUM &optional (CL +us-currency+))
    (COND
      ;; check parameters
      ((NOT (NUMBERP NUM)) (PRINT "NOT NUM") NIL)
      ((NOT (LISTP CL)) (PRINT "NOT LIST") NIL)
      ((NOT (LISTP (CAR CL))) (PRINT "NOT LIST CL") NIL)

      ((NULL CL) NIL) ;; no more denominations
      ((ZEROP NUM) NIL) ;; no more change

      (T (LET (
               (CV (CAR (CAR CL)))
               (CN (CAR (CDR (CAR CL))))
               ))

         (COND
           ((>= AMOUNT CV) (CONS (LIST (TRUNCATE NUM CV) CN)))
           (T (MC NUM (CDR CL)))
           )
      )
   )
  )