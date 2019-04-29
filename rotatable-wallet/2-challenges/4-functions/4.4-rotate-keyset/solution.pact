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
        [id])
    )
