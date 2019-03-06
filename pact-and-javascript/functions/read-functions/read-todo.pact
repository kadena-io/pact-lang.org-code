(defun read-todo (id:integer)
  "Read todo at ID."
  (read todo-table (id-key id))
)
