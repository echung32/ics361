(DEFUN FILTER(IN)
  (COND
   ((NOT (LISTP IN)) (PRINT "not a list") NIL)
   ((NULL IN) NIL)
   ((NOT (NUMBERP(CAR IN)) (PRINT "not a number") NIL)
   ((< (CAR IN) 0) (FILTER (CONS IN)))
   (T (CONS (CDR IN) (FILTER (CONS IN)))))
   )
  )
