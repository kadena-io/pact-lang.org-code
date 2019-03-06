;; define and read keysets
(define-keyset 'todo-admin-keyset
  (read-keyset "todo-admin-keyset"))

;; create todos module administered by keyset
(module todos 'todo-admin-keyset

)
