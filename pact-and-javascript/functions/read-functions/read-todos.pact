(defun read-todos:[object{todo}] ()
  "Read all un-deleted todos."
  (filter (not-deleted)
    (map (read todo-table) (keys todo-table)))
)
