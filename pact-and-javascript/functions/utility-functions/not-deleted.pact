(defun not-deleted (obj:object{todo})
  "Utility to check deleted flag of todo OBJ."
  (not (at "deleted" obj)))
