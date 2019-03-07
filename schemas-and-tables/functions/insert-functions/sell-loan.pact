  (defun sell-loan (loanId:string userFullname:string investor:string seller:string
    loanAmount:integer price:integer attachment:list dateOfDrawdown:time)
    "Create loan transaction."
    (with-read uuid-tracker NEXT-UUID
      { "uuid" := id }
    (update uuid-tracker NEXT-UUID
      { "uuid": (+ id 1) })
    (with-read loans-table loanId {
      "entityName" := borrower,
      "loanAmount":= originalAmount,
      "loanName":= loanName,
      "utilization":= utilization
    }
      ;;For the first transaction, take originalAmount. Or else, take availableAmount from previous transaction.
    (with-default-read loan-history-table loanId{
       "availableAmount": originalAmount
       }{
       "availableAmount":= availableAmount
    }
    (let ((row {
       "id": id,
       "loanId": loanId,
       "userFullname": userFullname,
       "borrower": borrower,
       "investor": investor,
       "seller":seller,
       "loanName": loanName,
       "loanAmount": loanAmount,
       "price": price,
       "attachment": attachment,
       "originalAmount": originalAmount,
       "availableAmount": (- availableAmount loanAmount),
       "drawdownAmount": loanAmount,
       "dateOfDrawdown": dateOfDrawdown,
       "vote": ASSIGNED
    }))
    (insert loan-history-table (id-key id) row)))
    (update loans-table loanId{
      "utilization": (+ utilization loanAmount),
      "assigned": ASSIGNED
    })
    ;; return json of stored values
    (read loans-table loanId)
   ))
  )
