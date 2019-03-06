(defun amend-loanAmount (loanId:string loanAmount:integer)
  "Amend a loan : onChangeLoanAmount"
    (update loans-table loanId{
        "loanAmount":loanAmount
    }
  )
  (read loans-table loanId)
)
