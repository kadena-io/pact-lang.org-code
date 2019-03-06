  (defun read-loans ()
    "Read all loans."
    (select loans-table (constantly true))
  )
