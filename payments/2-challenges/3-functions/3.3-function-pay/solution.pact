;; --------------------------------------------------------
;;                          3.3-pay
;; --------------------------------------------------------

  ;; define a function named pay that takes parameters from, to, and amount
  (defun pay (from to amount)
    ;; use with-read to view the payments-table of the account from. bind the balance and keyset of this account to from-bal and keyset
    (with-read payments-table from { "balance":= from-bal, "keyset":= keyset }
      ;; enforce that the keyset is the keyset of the account
      (enforce-keyset keyset)
      ;; use with-read to view the balance of the to-bank account. bind this balance to a variable named to-bank-bal
      (with-read payments-table to { "balance":= to-bal }
        ;; enforce that the amount being transferred is greater than 0
        (enforce (> amount 0.0) "Negative Transaction Amount")
        ;; enforce that the balance of the user transferring value is greater than what is being transferred
        (enforce (>= from-bal amount) "Insufficient Funds")
        ;; update payments-table to reflect the new balance of the from account.
        (update payments-table from
                { "balance": (- from-bal amount) })
        ;; update the payments-table to reflect the new balance of the to-bal account.
        (update payments-table to
                { "balance": (+ to-bal amount) })
        ;; return a formatted string to say that the from account has paid the to account the amount paid
        (format "{} paid {} {}" [from to amount]))))
)
