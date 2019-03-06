(defun delete-todo (id:integer)
  "Delete todo entry at ID (by setting deleted flag)."
  (update todo-table (id-key id)
    { "deleted": true })
)
