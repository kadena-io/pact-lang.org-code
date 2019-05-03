;; ========================================================
;;                1.1-enforce-user-auth
;; ========================================================

;; define a function enforce-user-auth that takes a parameter id
(defun enforce-user-auth (id)
  ;; read keyset from the users table of a given id. Bind this keyset to a variable k.
  (with-read users id { "keyset":= k }
  ;; enforce keyset of value k
    (enforce-keyset k)
    )
)
