(define-keyset 'module-admin
  (read-keyset "module-admin-keyset"))

(define-keyset 'operate-admin
  (read-keyset "module-operate-keyset"))

(module auth 'module-admin

  (defschema user
    nickname:string
    keyset:keyset
    )

  (deftable users:{user})

  (defun create-user (id nickname keyset)
    (enforce-keyset 'operate-admin)
    (insert users id {
      "keyset": keyset,
      "nickname": nickname
      })

  (defun enforce-user-auth (id)
    (with-read users id { "keyset":= k }
      (enforce-keyset k)
      k)
  )

  ;; 1. Define a function change-nickname that takes parameters id and new-name

    ;; 2. Enforce user authorization to the id provided

    ;; 3. Update the users nickname to the new-name using the given id

    ;; 4. Return a message to the user formatted as "Updated name for user [id] to [name]"

)

(create-table users)
