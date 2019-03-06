(defun edit-todo (id:integer entry date)
  "Update todo ENTRY at ID."
  (let ((key (enforce-not-deleted id)))
    (update todo-table key
      { "entry": entry, "date": date})
  )
)
