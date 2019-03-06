(defun reject-loan (loanId:string)
  "Reject the assigned Loan"
  (update loans-table loanId{
    "assigned": REJECTED
  })
  (read loans-table loanId)
)
