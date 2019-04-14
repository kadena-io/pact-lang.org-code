;; ------------------------------------------------
;;               2-loan-history
;; ------------------------------------------------

  ;; define schema named loan-history with the column names and types as shown
  (defschema loan-history
    ;; column loanId of type string
    loanId:string
    ;; column buyer of type string
    buyer:string
    ;; column seller of type string
    seller:string
    ;; column amount of type integer
    amount:integer
    )
