;; ========================================================
;;                    2.4-pay
;; ========================================================

(defun pay (from to amount)
  (with-read accounts-table from { "balance":= from-bal }
    ;; call enforce-user-auth from auth with parameter from
    
    ;; --------------------END OF CHALLENGE -------------------
    (with-read accounts-table to { "balance":= to-bal }
      (enforce (> amount 0.0) "Negative Transaction Amount")
      (enforce (>= from-bal amount) "Insufficient Funds")
      (update accounts-table from
              { "balance": (- from-bal amount) })
      (update accounts-table to
              { "balance": (+ to-bal amount) })
      (format "{} paid {} {}" [from to amount]))))
