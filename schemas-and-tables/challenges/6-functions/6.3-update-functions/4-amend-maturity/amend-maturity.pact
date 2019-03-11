(defun amend-maturity (loanId:string maturity:time)
  "Amend a loan: Maturity Date"
    (update loans-table loanId{
        "maturityDate": maturity
    }
  )
  (read loans-table loanId)
)
