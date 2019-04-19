;; ------------------------------------------------
;;               5.2-create-a-loan
;; ------------------------------------------------

;; define a function named create-a-loan that takes the parameters loanId, loanName, entityName, and loanAmount
(defun create-a-loan (loanId loanName entityName loanAmount)
  ;; insert data into loans-table using the loanId
  (insert loans-table loanId {
    ;; insert "loanName" as value of loanName
    "loanName":loanName,
    ;; insert "entityName" as value of entityName
    "entityName":entityName,
    ;; insert "loanAmount" as value of loanAmount
    "loanAmount":loanAmount,
    ;; insert "status" as value INITIATED
    "status":INITIATED
    })
  ;; insert to loan inventory table with the parameters inventory-key, loanId, and entity name
  (insert loan-inventory-table (inventory-key loanId entityName){
    ;; insert "balance" as value loanAmount
    "balance": loanAmount
    }))
