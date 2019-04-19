;; --------------------------------------------------------
;;                        3.2-get-balance
;; --------------------------------------------------------

  ;; define a function get-balance that takes an argument id
  (defun get-balance (id)
    ;; uses with-read to view the id from the payments-table
    (with-read payments-table id
      ;; bind the value of the balance and keyset of the given id to variables named balance and keyset
      { "balance":= balance, "keyset":= keyset }
      ;; use enforce-one to check that the keyset of the user calling the function is either the admin-keyset or the keyset of the provided id
      (enforce-one "Access denied"
        [(enforce-keyset keyset)
         (enforce-keyset 'admin-keyset)])
      ;; return balance
      balance))
