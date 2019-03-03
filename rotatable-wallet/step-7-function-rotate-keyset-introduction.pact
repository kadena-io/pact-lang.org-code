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

  (defun change-nickname (id new-name)
    (enforce-user-auth id)
    (update users id { "nickname": new-name })
    (format "Updated name for user {} to {}"
      [id new-name]))

    ;; 1. Define a function rotate-keyset that takes the parameters id and new-keyset

      ;; 2. Enforce user authorization to the provided id

      ;; 3. Update the keyset to the new-keyset for the id in the users table

      ;; 4. Return a message describing the update in the format "Updated keyset for user [id]"

  )
