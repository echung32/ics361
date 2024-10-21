(DEFUN FACTORIAL(NUM)
  (COND
   ((EQ NUM 1) 1)
   (T (* NUM (FACTORIAL(1- NUM))))
   )
  )