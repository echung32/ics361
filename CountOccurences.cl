(DEFUN OCCUR(A B)
  (COND
   ; return NIL so that it will throw an error when attempting to add.
   ((NOT (LISTP B)) (PRINT "l err") NIL)
   ((NULL B) 0)
   ; first element of B is just a value, so add to counts.
   ; EQ compares atoms, EQUAL compares lists OR atoms.
   ((EQ A (CAR B)) (+ 1 (OCCUR A (CDR B))))
   ; first element of B is a list.
   ; add amount of that first element, then continue recursion.
   ((LISTP (CAR B)) (+ (OCCUR A (CAR B)) (OCCUR A (CDR B))))
   ; continue recursion with rest of list
   (T (OCCUR A (CDR B)))
   )
  )
