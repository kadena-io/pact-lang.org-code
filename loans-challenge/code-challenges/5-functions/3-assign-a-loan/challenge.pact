;; ------------------------------------------------
;;              assign-a-loan
;; ------------------------------------------------

;; define a function named assign-a-loan that takes parameters txid, loanId, buyer, and amount

  ;; read from loans-table using loanId

    ;; bind "entityName" to the value of entityName

    ;; bind "loanAmount" to the value of issuerBalance


    ;;insert into loan-history-table using the value of txid

      ;; insert "loanId" as value of loanId

      ;; insert "buyer" as value of buyer

      ;; insert "seller" as value of entityName

      ;; insert "amount" as value of amount


    ;; insert to loan-inventory-table with the parameters inventory-key, loanId, and buyer

      ;; insert "balance" as value of amount


    ;; update loan-inventory-table with the parameters inventory-key, loanId, and entityName

      ;; update new balance of the issuer in the inventory table


    ;; update loans-table using loanId

      ;; update "status" to value ASSIGNED
