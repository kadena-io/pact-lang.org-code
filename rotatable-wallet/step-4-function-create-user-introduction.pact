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

  ;; 1. Define a function create-user that takes arguments id, nickname, and keyset

    ;; 2. Restrict access to function call to operate-admin

    ;; 3. Insert a row into the users table at the given id, keyset, and nickname

)
