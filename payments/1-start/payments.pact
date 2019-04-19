;; ========================================================
;;                   1-module-and-keyset
;; ========================================================

;; define and read a keyset named admin-keyset

;; create a module named payments that gives access to admin-keyset


;; ========================================================
;;                   2-define-schemas-and-table
;; ========================================================

  ;; define the schema for payments including balance as type decimal and keyset as type keyset



  ;; define the payments-table using the schema {payments} created above


;; ========================================================
;;                          3-functions
;; ========================================================

;; --------------------------------------------------------
;;                        3.1-create-account
;; --------------------------------------------------------

  ;; define a function create-account with parameters id, initial-balance, and keyset

    ;; uses enforce-keyset to ensure that the account is being created by the administrator

    ;; uses enforce to ensure an initial-balance > 0

    ;; insert the initial-balance and keyset into the payments-table




;; --------------------------------------------------------
;;                        3.2-get-balance
;; --------------------------------------------------------

  ;; define a function get-balance that takes an argument id

    ;; uses with-read to view the id from the payments-table

      ;; bind the value of the balance and keyset of the given id to variables named balance and keyset

      ;; use enforce-one to check that the keyset of the user calling the function is either the admin-keyset or the keyset of the provided id



      ;; return balance


;; --------------------------------------------------------
;;                          3.3-pay
;; --------------------------------------------------------

  ;; define a function named pay that takes parameters from, to, and amount

    ;; use with-read to view the payments-table of the account from. bind the balance and keyset of this account to from-bal and keyset

      ;; enforce that the keyset is the keyset of the account

      ;; use with-read to view the balance of the to-bank account. bind this balance to a variable named to-bank-bal

        ;; enforce that the amount being transferred is greater than 0

        ;; enforce that the balance of the user transferring value is greater than what is being transferred

        ;; update payments-table to reflect the new balance of the from account.


        ;; update the payments-table to reflect the new balance of the to-bal account.


        ;; return a formatted string to say that the from account has paid the to account the amount paid



;; ========================================================
;;                        4-create-table
;; ========================================================

;; create payments-table


;; ========================================================
;;                       5-create-accounts
;; ========================================================

;; create account for Sarah with initial value of 100.25

;; create account for James with initial value of 250.0


;; ========================================================
;;                        6-make-payment
;; ========================================================

;; do payment of 25.0 from Sarah to James


;; read Sarah's balance as Sarah


;; read James' balance as JAMES
