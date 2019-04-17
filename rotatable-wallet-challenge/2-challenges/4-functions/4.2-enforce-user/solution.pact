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
