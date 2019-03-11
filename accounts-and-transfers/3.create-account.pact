(defun create-account (id initial-balance keyset)
  "Create a new account for ID with INITIAL-BALANCE funds, must be administrator."
  (enforce-keyset 'admin-keyset)
  (enforce (>= initial-balance 0.0) "Initial balances must be >= 0.")
  (insert payments-table id
          { "balance": initial-balance,
            "keyset": keyset }))
