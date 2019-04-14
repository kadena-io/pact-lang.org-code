;; ------------------------------------------------
;;               sell-a-loan
;; ------------------------------------------------

;; define a function named sell-a-loan that takes parameters txid, loanId, buyer, seller, and amount
(defun sell-a-loan (txid loanId buyer seller amount)
  ;; read from loan-inventory-table using paramters inventory-key, loanId, and seller
  (with-read loan-inventory-table (inventory-key loanId seller)
    ;; bind "balance" to value of prev-seller-balance
    {"balance":= prev-seller-balance}
    ;; read from loan-inventory-table with parameters inventory-key, loanId, and buyer
    (with-default-read loan-inventory-table (inventory-key loanId buyer)
      ;; assign "balance" to 0
      {"balance" : 0}
      ;; bind "balance" to value of prev-buyer-balance
      {"balance":= prev-buyer-balance}
    ;; insert to loan-history-table at the given txid
    (insert loan-history-table txid {
      ;; insert "loanId" as value of loanId
      "loanId":loanId,
      ;; insert "buyer" as value of buyer
      "buyer":buyer,
      ;; insert "seller" as value of seller
      "seller":seller,
      ;; insert "amount" as value of amount
      "amount": amount
      })
    ;; update the loan-inventory-table with parameters inventory-key, loanId, and seller
    (update loan-inventory-table (inventory-key loanId seller)
      ;; set "balance" the previous-seller-balance minus the amount
      {"balance": (- prev-seller-balance amount)})
    ;; write to the loan-inventory-table with parameters inventory-key, loanId, and buyer
    (write loan-inventory-table (inventory-key loanId buyer)
      ;; set "balance" the previous-seller-balance plus the amount
      {"balance": (+ prev-buyer-balance amount)}))))
