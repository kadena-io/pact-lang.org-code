(defun amend-rate (loanId:string rate:decimal)
  "Amend a loan: rate"
    (update loans-table loanId{
        "rate":rate
    }
  )
  (read loans-table loanId)
)

)
