;; global keyset of people
;; who can define/update modules
(define-keyset 'module-admin
  (read-keyset "module-admin-keyset"))

;; global keyset of
;; people with "operate" role
(define-keyset 'operate-admin
  (read-keyset "module-operate-keyset"))

(module auth 'module-admin

  ;; user data row type
  ;; with "row-level keysets"
  (defschema user
    nickname:string
    keyset:keyset
    )

  ;; user data table
  (deftable users:{user})

  (defun create-user (id nickname keyset)
    (enforce-keyset 'operate-admin)
    (insert users id {
      "keyset": (read-keyset keyset),
      "nickname": nickname
      })
  )

  (defun enforce-user-auth (id)
    "Enforce keyset for user, and return keyset"
    (with-read users id { "keyset":= k }
      (enforce-keyset k)
      )
  )
)

(create-table users)
