;; ========================================================
;;                    1-define-keysets
;; ========================================================

;; define and read module-admin keyset
(define-keyset 'module-admin
  (read-keyset "module-admin-keyset"))

;; define and read operate-admin keyset
(define-keyset 'operate-admin
  (read-keyset "module-operate-keyset"))

;; ========================================================
;;                    2-define-module
;; ========================================================

;; create module named auth with access given to module-admin
(module auth 'module-admin

  ;; ========================================================
  ;;             3-define-schema-and-table
  ;; ========================================================

  ;; define schema user including nickname as type string and keyset as type keyset
  (defschema user
    nickname:string
    keyset:keyset
  )
  ;; define table named users with user schema
  (deftable users:{user})

  ;; ========================================================
  ;;                      4-functions
  ;; ========================================================

  ;; --------------------------------------------------------
  ;;                    4.1-create-user
  ;; --------------------------------------------------------

  ;; define a function create-user that takes arguments id, nickname, and keyset
  (defun create-user (id nickname keyset)
    ;; enforce access to restrict function calls to the operate-admin
    (enforce-keyset 'operate-admin)
    ;; insert a row into the users table at the given id, keyset, and nickname
    (insert users id {
      "keyset": keyset,
      "nickname": nickname
      })
    )

  ;; --------------------------------------------------------
  ;;                4.2-enforce-user-auth
  ;; --------------------------------------------------------

  ;; define a function enforce-user-auth that takes a parameter (id)
  (defun enforce-user-auth (id)
    ;; read users table to find id then bind value k equal this id's keyset
    (with-read users id { "keyset":= k }
      ;; enforce user authorization of data to the given keyset
      (enforce-keyset k)
      ;; return the value of the keyset
      k)
  )
  ;; --------------------------------------------------------
  ;;                 4.3-change-nickname
  ;; --------------------------------------------------------

  ;; define a function change-nickname that takes parameters id and new-name
  (defun change-nickname (id new-name)
    ;; enforce user authorization to the id provided
    (enforce-user-auth id)
    ;; update the users nickname to the new-name using the given id
    (update users id { "nickname": new-name })
    ;; return a message to the user formatted as "Updated name for user [id] to [name]"
    (format "Updated name for user {} to {}"
      [id new-name]))

  ;; --------------------------------------------------------
  ;;                 4.4-rotate-keyset
  ;; --------------------------------------------------------

  ;; define a function rotate-keyset that takes the parameters id and new-keyset
  (defun rotate-keyset (id new-keyset)
    ;; enforce user authorization to the provided id
    (enforce-user-auth id)
    ;; update the keyset to the new-keyset for the id in the users table
    (update users id { "keyset": new-keyset})
    ;; return a message describing the update in the format "Updated keyset for user [id]"
    (format "Updated keyset for user {}"
      [id]))
)

;; ========================================================
;;                      5-create-table
;; ========================================================

;; create the users table
(create-table users)
