(defun read-assigned-loan (loanId:string)
    "Read history of an entity."
   (select loan-history-table (and (where "assigned" (= INITIATED)) (where "loanId" (= loanId)))))
