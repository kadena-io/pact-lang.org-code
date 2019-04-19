;; ------------------------------------------------
;;                  2.1-loan
;; ------------------------------------------------

;; define schema named loan with the column names and types as shown
  (defschema loan
    ;; column loanName of type string
    loanName:string
    ;; column entityName of type string
    entityName:string
    ;; column loanAmount of type integer
    loanAmount:integer
    ;; column status of type string
    status:string
    )
