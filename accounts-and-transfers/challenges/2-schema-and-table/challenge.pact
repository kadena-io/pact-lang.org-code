;; --------------------------------------
;;        Step 1: Set Up Module
;; --------------------------------------

;; define keyset to guard module
(define-keyset 'admin-keyset (read-keyset "admin-keyset"))

;; define smart-contract code
(module bank-transfer 'admin-keyset

;; --------------------------------------
;;        Step 2: Schemas and Tables
;; --------------------------------------

  (defschema bank-table
    total-funds:decimal
    keyset:keyset)

;; --------------------------------------
;;    Step 3: FUNCTION: Create Account
;; --------------------------------------

  (defun create-bank (bankId total-funds keyset)
    "Create a new account for ID with INITIAL-BALANCE funds, must be administrator."
    (enforce-keyset 'admin-keyset)
    (enforce (>= total-funds 1000.0) "Initial balances must be >= 1000.0.")
    (insert bank-table bankId
            { "balance": total-funds,
              "keyset": keyset }))

;; --------------------------------------
;;       Step 4: FUNCTION: Get Balance
;; --------------------------------------

  (defun view-total-funds (bankId)
    "Only users or admin can read balance."
    (with-read bank-table id
      { "total-funds":= total-funds, "bank-keyset":= bank-keyset }
      (enforce-one "Access denied"
        [(enforce-keyset bank-keyset)
         (enforce-keyset 'admin-keyset)])
      total-funds))

;; --------------------------------------
;;        Step 5: FUNCTION: Pay
;; --------------------------------------

;; Step 5 code goes here

)

;; --------------------------------------
;;      Step 6: Accounts
;; --------------------------------------

;; Step 6 code goes here

;; --------------------------------------
;;      Step 7: Transfer
;; --------------------------------------

;; Step 7 code goes here
