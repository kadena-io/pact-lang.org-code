;; ------------------------------------------------
;;               sell-a-loan
;; ------------------------------------------------

;; define a function named sell-a-loan that takes parameters txid, loanId, buyer, seller, and amount

  ;; read from loan-inventory-table using paramters inventory-key, loanId, and seller

    ;; bind "balance" to value of prev-seller-balance

    ;; read from loan-inventory-table with parameters inventory-key, loanId, and buyer

      ;; assign "balance" to 0

      ;; bind "balance" to value of prev-buyer-balance

    ;; insert to loan-history-table at the given txid

      ;; insert "loanId" as value of loanId

      ;; insert "buyer" as value of buyer

      ;; insert "seller" as value of seller

      ;; insert "amount" as value of amount


    ;; update the loan-inventory-table with parameters inventory-key, loanId, and seller

      ;; set "balance" the previous-seller-balance minus the amount

    ;; write to the loan-inventory-table with parameters inventory-key, loanId, and buyer

      ;; set "balance" the previous-seller-balance plus the amount
