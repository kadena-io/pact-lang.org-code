;; define-keysets
(define-keyset 'module-admin
  (read-keyset "module-admin-keyset"))

(define-keyset 'operate-admin
  (read-keyset "module-operate-keyset"))

;; define-module
(module auth 'module-admin

  ;; define-schema-and-table
  (defschema user
    nickname:string
    keyset:keyset
    )

  (deftable users:{user})

  ;; create-user
  (defun create-user (id nickname keyset)
    (enforce-keyset 'operate-admin)
    (insert users id {
      "keyset": (read-keyset keyset),
      "nickname": nickname
      })
  )

  ;; ========================================================
  ;;                1.1-enforce-user-auth
  ;; ========================================================

  ;; define a function enforce-user-auth that takes a parameter id
  
    ;; read keyset from the users table of a given id. Bind this keyset to a variable k.

    ;; enforce keyset of value k



)

;; create-table
(create-table users)
