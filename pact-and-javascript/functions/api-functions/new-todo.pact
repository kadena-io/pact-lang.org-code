(defun new-todo (entry date)
  "Create new todo with ENTRY and DATE."
  (with-read uuid-tracker NEXT-UUID
    { "uuid" := id }
    (update uuid-tracker NEXT-UUID
      { "uuid": (+ id 1) })
    (insert todo-table (id-key id)
      { "id": id,
        "deleted": false,
        "state": ACTIVE,
        "entry": entry,
        "date": date
      })
    ;; return json of stored values
    {"id": id, "state":ACTIVE, "entry":entry, "date":date}
  )
)
