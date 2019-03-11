;; ======================================
;;        Step 1: Set Up Module
;; ======================================

(define-keyset 'admin-keyset (read-keyset "admin-keyset"))

(module payments 'admin-keyset

;; ======================================
;;       Step 2: Schemas and Tables
;; ======================================

  (defschema payments
    balance:decimal
    keyset:keyset)

  (deftable payments-table:{payments})

;; ======================================
;;   Step 3: FUNCTION: Create Account
;; ======================================

  (defun create-account (id initial-balance keyset)
    (enforce-keyset 'admin-keyset)
    (enforce (>= initial-balance 0.0) "Initial balances must be >= 0.")
    (insert payments-table id
            { "balance": initial-balance,
              "keyset": keyset }))

;; ======================================
;;     Step 4: FUNCTION: Get Balance
;; ======================================

  (defun get-balance (id)
    "Only users or admin can read balance."
    (with-read payments-table id
      { "balance":= balance, "keyset":= keyset }
      (enforce-one "Access denied"
        [(enforce-keyset keyset)
         (enforce-keyset 'admin-keyset)])
      balance))

;; ======================================
;;         Step 5: FUNCTION: Pay
;; ======================================

  (defun pay (from to amount)
    (with-read payments-table from { "balance":= from-bal, "keyset":= keyset }
      (enforce-keyset keyset)
      (with-read payments-table to { "balance":= to-bal }
        (enforce (> amount 0.0) "Negative Transaction Amount")
        (enforce (>= from-bal amount) "Insufficient Funds")
        (update payments-table from
                { "balance": (- from-bal amount) })
        (update payments-table to
                { "balance": (+ to-bal amount) })
        (format "{} paid {} {}" [from to amount]))))

)

(create-table payments-table)

;; ======================================
;;             Step 6: Accounts
;; ======================================

(create-account "Sarah" 100.25 (read-keyset "sarah-keyset"))
(create-account "James" 250.0 (read-keyset "james-keyset"))

;; ======================================
;;             Step 7: Transfer
;; ======================================

(pay "Sarah" "James" 25.0)
(format "Sarah's balance is {}" [(get-balance "Sarah")])

(format "James's balance is {}" [(get-balance "James")])
