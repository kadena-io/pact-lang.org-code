;; ========================================================
;;                  2.2-create-account
;; ========================================================

(defun create-account (userId initial-balance)
  "Create a new account for ID with INITIAL-BALANCE funds, must be administrator."
  ;; call enforce-user-auth from auth with parameter userId
  
  ;; --------------------END OF CHALLENGE -------------------
  (enforce (>= initial-balance 0.0) "Initial balances must be >= 0.")
  (insert accounts-table userId
          { "balance": initial-balance}))
