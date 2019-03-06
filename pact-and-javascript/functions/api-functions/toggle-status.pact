(defun toggle-todo-status (id:integer)
  "Toggle ACTIVE/COMPLETED status flag for todo at ID."
  (let ((key (enforce-not-deleted id)))
    (with-read todo-table key
      { "state" := state }
      (update todo-table key
        { "state":
            (if (= state ACTIVE) COMPLETED ACTIVE)
        })
    )
  )
)
