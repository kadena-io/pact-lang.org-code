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
