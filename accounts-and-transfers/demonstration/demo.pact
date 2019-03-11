;; ======================================
;;        Step 1: Module and Keyset
;; ======================================

(define-keyset 'admin-keyset (read-keyset "admin-keyset"))

(module bank-transfer 'admin-keyset

;; ======================================
;;        Step 2: Schemas and Tables
;; ======================================

  (defschema bank
    total-funds:decimal
    keyset:keyset)

  (deftable bank-table:{bank})

;; ======================================
;;    Step 3: FUNCTION: Create Account
;; ======================================

  (defun create-bank (bank-id total-funds keyset)
    (enforce-keyset 'admin-keyset)
    (enforce (>= total-funds 0.0) "Initial balances must be >= 1000.0.")
    (insert bank-table bank-id
            { "total-funds": total-funds,
              "keyset": keyset }))

;; ======================================
;;       Step 4: FUNCTION: Get Balance
;; ======================================

  (defun view-total-funds (bank-id)
    "Only users or admin can read balance."
    (with-read bank-table bank-id
      { "total-funds":= total-funds, "keyset":= keyset }
      (enforce-one "Access denied"
        [(enforce-keyset keyset)
         (enforce-keyset 'admin-keyset)])
      total-funds))

;; =============================================
;;        Step 5: FUNCTION: Transfer Funds
;; =============================================

  (defun transfer-funds (from-bank to-bank total-funds)
    (with-read bank-table from-bank { "total-funds":= from-bank-bal, "keyset":= keyset }
      (enforce-keyset keyset)
      (with-read bank-table to-bank { "total-funds":= to-bank-bal }
        (enforce (> total-funds 0.0) "Negative Transaction Amount")
        (enforce (>= from-bank-bal total-funds) "Insufficient Funds")
        (update bank-table from-bank
                { "total-funds": (- from-bank-bal total-funds) })
        (update bank-table to-bank
                { "total-funds": (+ to-bank-bal total-funds) })
        (format "{} paid {} {}" [from-bank to-bank total-funds]))))
)

;; create table
(create-table bank-table)

;; ======================================
;;            Step 6: Accounts
;; ======================================

;; create banks
(create-bank "bank-1" 5000.0 (read-keyset "bank-1-keyset"))
(create-bank "bank-2" 10000.0 (read-keyset "bank-2-keyset"))

;; ======================================
;;         Step 7: Transfer Funds
;; ======================================

(transfer-funds "bank-1" "bank-2" 1000.0)
(format "bank-1 balance is {}" [(view-total-funds "bank-1")])
(format "bank-2 balance is {}" [(view-total-funds "bank-2")])
