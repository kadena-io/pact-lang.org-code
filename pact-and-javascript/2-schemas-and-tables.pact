(module todos 'todo-admin-keyset
  ;; Define todo schema
  (defschema todo
    "Row type for todos."
     id:integer
     deleted:bool
     state:string
     entry:string
     date:string
     )

  ;; Define todo table
  (deftable todo-table:{todo})

  ;; Define uuid schema
  (defschema uuid
    uuid:integer
    )

  ;; Define uuid table
  (deftable uuid-tracker:{uuid})

)

;; Create todo table

;; Create uuid table
