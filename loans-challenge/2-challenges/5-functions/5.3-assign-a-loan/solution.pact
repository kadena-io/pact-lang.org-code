;; ------------------------------------------------
;;              5.3-assign-a-loan
;; ------------------------------------------------

;; define a function named assign-a-loan that takes parameters txid, loanId, buyer, and amount
(defun assign-a-loan (txid loanId buyer amount)
  ;; read from loans-table using loanId
  (with-read loans-table loanId {
    ;; bind "entityName" to the value of entityName
    "entityName":= entityName,
    ;; bind "loanAmount" to the value of issuerBalance
    "loanAmount":= issuerBalance
    }
    ;;insert into loan-history-table using the value of txid
    (insert loan-history-table txid {
      ;; insert "loanId" as value of loanId
      "loanId":loanId,
      ;; insert "buyer" as value of buyer
      "buyer":buyer,
      ;; insert "seller" as value of entityName
      "seller":entityName,
      ;; insert "amount" as value of amount
      "amount": amount
      })
    ;; insert to loan-inventory-table with the parameters inventory-key, loanId, and buyer
    (insert loan-inventory-table (inventory-key loanId buyer) {
      ;; insert "balance" as value of amount
      "balance":amount
      })
    ;; update loan-inventory-table with the parameters inventory-key, loanId, and entityName
    (update loan-inventory-table (inventory-key loanId entityName){
      ;; update new balance of the issuer in the inventory table
      "balance": (- issuerBalance amount)
      }))
    ;; update loans-table using loanId
    (update loans-table loanId {
      ;; update "status" to value ASSIGNED
      "status": ASSIGNED
      }))
