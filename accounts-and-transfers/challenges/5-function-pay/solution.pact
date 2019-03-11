;; Define a function named pay that takes the parameters from, to, and amount.
(defun pay (from to amount)
  ;; View the payments-table of the "from" account. Bind the balance an keyset of this account to from-bal and keyset.
  (with-read payments-table from { "balance":= from-bal, "keyset":= keyset }
    ;; Enforce that the keyset is the keyset of the account
    (enforce-keyset keyset)
    ;; View the balance of the "to" account. Bind this balance to a variable named to-bal.
    (with-read payments-table to { "balance":= to-bal }
      ;; Enforce that the amount being transferred is greater than 0.
      (enforce (> amount 0.0) "Negative Transaction Amount")
      ;; Enforce that the balance of the user transferring value is greater than what is being transferred.
      (enforce (>= from-bal amount) "Insufficient Funds")
      ;; Update payments-table to reflect the new balance of the "from" account. This balance is equal to the original balance minus the amount transferred.
      (update payments-table from
              { "balance": (- from-bal amount) })
      ;; Update the payments-table to reflect the new balance of the "to" account. This balance is equal to the original balance plus the amount transferred.
      (update payments-table to
              { "balance": (+ to-bal amount) })
      ;; Return a message to the user calling the function. This should be a string formatted to say that the from account has paid the to account a certain amount.
      (format "{} paid {} {}" [from to amount]))))
