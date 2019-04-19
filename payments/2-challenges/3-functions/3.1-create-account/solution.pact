;; --------------------------------------------------------
;;                        3.1-create-account
;; --------------------------------------------------------

  ;; define a function create-account with parameters id, initial-balance, and keyset
  (defun create-account (id initial-balance keyset)
    ;; uses enforce-keyset to ensure that the account is being created by the administrator
    (enforce-keyset 'admin-keyset)
    ;; uses enforce to ensure an initial-balance > 0
    (enforce (>= initial-balance 0.0) "Initial balances must be >= 1000.0.")
    ;; insert the initial-balance and keyset into the payments-table
    (insert payments-table id
            { "balance": initial-balance,
              "keyset": keyset }))
