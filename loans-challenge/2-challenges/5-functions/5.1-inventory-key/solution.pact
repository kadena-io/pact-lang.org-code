;; ------------------------------------------------
;;               5.1-inventory-key
;; ------------------------------------------------

;; define a function named inventory-key that takes inputs loanId:string and owner:string
(defun inventory-key (loanId:string owner:string)
   ;; format a composite key from OWNER and LoanId in the format "loanId:owner"
   (format "{}:{}" [loanId owner])
 )
