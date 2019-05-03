;; ========================================================
;;                 2.3-get-balance
;; ========================================================

(defun get-balance (userId)
  "Only admin can read balance."
  ;; call enforce-user-auth from auth with parameter admin
  (enforce-user-auth 'admin)
  ;; --------------------END OF CHALLENGE -------------------
  (with-read accounts-table userId
    { "balance":= balance }
    balance))
