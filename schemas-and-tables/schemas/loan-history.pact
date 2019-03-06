  ;; loan schema and table
  (defschema loan
    "Row type for loans."
    loanId:string
    cusip:string
    loanAmount:integer
    loanName:string
    maturityDate:time
    rate:decimal
    utilization:integer
    rating:string
    attachments:list
    reference:string
    paymentFrequency:integer
    assigned:string
    entityId:integer
    entityName:string
    sector:string
    program:string
    programSize:integer
    position:integer
    userFullname:string
    amendment:object
  )
