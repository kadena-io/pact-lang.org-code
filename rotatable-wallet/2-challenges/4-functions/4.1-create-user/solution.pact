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
