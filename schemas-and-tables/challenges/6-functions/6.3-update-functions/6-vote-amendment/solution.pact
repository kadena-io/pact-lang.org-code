  (defun vote-amendment (loanId entityName:string vote:bool)
    "vote as an entity on amendment"
    (with-read loans-table loanId{
      "amendment":= amendment
    }
    (update loans-table loanId {
      "amendment": (+ {entityName: vote} amendment)
    }))
  )
