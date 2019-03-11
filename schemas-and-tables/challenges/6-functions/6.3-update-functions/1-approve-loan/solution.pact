(defun approve-loan (loanId:string)
  "Approve the assigned Loan"

  (update loans-table loanId{
    "assigned": APPROVED
  })
  (read loans-table loanId)
)
