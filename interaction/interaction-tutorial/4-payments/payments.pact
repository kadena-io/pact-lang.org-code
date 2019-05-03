;;
;; Simple accounts model.
;;
;;---------------------------------
;;
;;  Create keysets named 'admin-keyset', 'sarah-keyset' and 'james-keyset' and
;;  add some keys to them for loading this contract.
;;
;;  Make sure the message is signed with those added keys as well.
;;
;;---------------------------------


;define keyset to guard module
(define-keyset 'admin-keyset (read-keyset "admin-keyset"))

;define smart-contract code
(module payments 'admin-keyset

  (use auth)

  (defschema accounts
    balance:decimal)

  (deftable accounts-table:{accounts})

  (defun create-account (userId initial-balance)
    "Create a new account for ID with INITIAL-BALANCE funds, must be administrator."
    (enforce-user-auth userId)
    (enforce (>= initial-balance 0.0) "Initial balances must be >= 0.")
    (insert accounts-table userId
            { "balance": initial-balance}))

  (defun get-balance (userId)
    "Only admin can read balance."
    (enforce-user-auth 'admin)
    (with-read accounts-table userId
      { "balance":= balance }
      balance))

  (defun pay (from to amount)
    (with-read accounts-table from { "balance":= from-bal }
      (enforce-user-auth from)
      (with-read accounts-table to { "balance":= to-bal }
        (enforce (> amount 0.0) "Negative Transaction Amount")
        (enforce (>= from-bal amount) "Insufficient Funds")
        (update accounts-table from
                { "balance": (- from-bal amount) })
        (update accounts-table to
                { "balance": (+ to-bal amount) })
        (format "{} paid {} {}" [from to amount]))))

)

;define table
(create-table accounts-table)
