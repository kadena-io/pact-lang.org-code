(module loans 'loans-admin-keyset
  " Smart contract module for Commercial Paper pact app.   \
  \ Tables:                                        \
  \ entity -- holds entity entries                 \
  \ loan -- holds loan entries                     \
  \ loan-history -- tracks loan's history          \
  \ loan-amendment -- tracks loan's amendment      \
  \ uuid -- adds id to loan transaction            "

  ;; entity schema and table
  (defschema entity
    "Row type for entity"
    id:integer
    sector:string
    entityId:integer
    entityName:string
    program:string
    programSize:integer
    position:integer
    userFullname:string
  )

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

  ;; loan-history schema and table
  (defschema loan-history
    "Row type for loan transaction"
    id:integer
    loanId:string
    loanName:string
    userFullname:string
    borrower:string
    seller:string
    investor:string
    loanAmount:integer
    attachment:list
    price:integer
    originalAmount:integer
    availableAmount:integer
    drawdownAmount:integer
    dateOfDrawdown:time
    vote:string
  )

  ;; uuid schema and singleton table
  (defschema uuid
    "create and track uuids for loan transactions"
    uuid:integer
  )

  (defschema loanId
    "create and track loanIds"
    loanId:integer
  )

  (deftable entity-table:{entity})
  (deftable loans-table:{loan})
  (deftable loan-history-table:{loan-history})
  (deftable uuid-tracker:{uuid})
  (deftable loanId-tracker:{loanId})

  ;; amendment state consts for loan transaction
  (defconst NONE "none")
  (defconst RATE "rate")
  (defconst MATURITY "maturity")
  (defconst AMOUNT "amount")

  ;; vote state consts for loan transaction
  (defconst INITIATED "initiated")
  (defconst ASSIGNED "assigned")
  (defconst APPROVED "approved")
  (defconst REJECTED "rejected")

  ;; key for uuid singleton table
  (defconst NEXT-UUID "next-uuid")
  (defconst NEXT-LOANID "next-loanId")

  ;; API functions
  ;;

  (defun id-key (id:integer)
    "Format ID integer value as loans row key."
    (format "{}" [id])
  )

  (defun create-loan (entityName cusip userFullname loanName
    loanAmount maturityDate utilization paymentFrequency
    reference rating attachments rate)
    "Create a new loan"
    (with-read loanId-tracker NEXT-LOANID
      { "loanId" := id }
    (update loanId-tracker NEXT-LOANID
      { "loanId": (+ id 1) })
    (with-read entity-table entityName{
      "sector":= sector,
      "program":= program,
      "programSize":= programSize,
      "entityId":= entityId,
      "position":= position
    }
    (let (
      (row {
        "userFullname": userFullname,
        "loanId": (format "B-3834431467-{}" [id]),
        "cusip": cusip,
        "entityId": entityId,
        "entityName": entityName,
        "loanAmount": loanAmount,
        "sector": sector,
        "program": program,
        "programSize": programSize,
        "loanName": loanName,
        "maturityDate": maturityDate,
        "rate": rate,
        "position": position,
        "utilization": utilization,
        "rating": rating,
        "attachments": attachments,
        "paymentFrequency": paymentFrequency,
        "reference": reference,
        "assigned": INITIATED,
        "amendment": {}
      })
      )
      (insert loans-table (format "B-3834431467-{}" [id]) row)
      row
    )))
  )

  (defun vote-amendment (loanId entityName:string vote:bool)
    "vote as an entity on amendment"
    (with-read loans-table loanId{
      "amendment":= amendment
    }
    (update loans-table loanId {
      "amendment": (+ {entityName: vote} amendment)
    }))
  )

  (defun read-loans ()
    "Read all loans."
    (select loans-table (constantly true))
  )

  (defun read-entity ()
    "Read all entity."
    (select entity-table (constantly true))
  )

  (defun read-history-for-loan ()
    "Read history of a loan."
  (select loan-history-table (constantly true)))

  ;(defun read-entity-in-a-loan (loanId:string)
  ;  "Read all entities with the loan"
  ;  (select loan-history-table ["investor"] (constantly true))
  ;)
  ;;Query all buyers & get the balance for all.
  ;(defun read-entity-balance-for-loan (loanId:string entityName:string)
  ;  "Read balance of an entity for a loan"
  ;  ( +
    ; query the amount where entity was a buyer. Expect the value to be a list of objects [{loanAmount: 100}, ...].
  ;  (fold (+) 0 (map (at "loanAmount") (select loan-history-table ["loanAmount"] (and (where "loanId" (= loanId)) (where "investor" (= entityName)) ))))
    ; query the amount where entity was a seller. Expect the value to be a list of objects [{loanAmount: 100}, ...]
  ;  (fold (+) 0 (map (at "loanAmount") (select loan-history-table ["loanAmount"] (where (and "loanId" (= loanId) "seller" (= entityName) )))))
  ;)
  ;(select loan-history-table ["loanAmount"] (and (where "loanId" (= loanId)) (where "entityName" (= entityName))))
;  )

(defun read-assigned-loan (loanId:string)
    "Read history of an entity."
   (select loan-history-table (and (where "assigned" (= INITIATED)) (where "loanId" (= loanId)))))

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

 ;(defun sell-loan-json ()
  ; (sell-loan (read-msg "loadId") (read loanId:string userFullname:string investor:string seller:string
  ;   loanAmount:integer price:integer attachment:list dateOfDrawdown:time)
  ;   )
  ;)

(defun approve-loan (loanId:string)
  "Approve the assigned Loan"

  (update loans-table loanId{
    "assigned": APPROVED
  })
  (read loans-table loanId)
)

(defun reject-loan (loanId:string)
  "Reject the assigned Loan"
  (update loans-table loanId{
    "assigned": REJECTED
  })
  (read loans-table loanId)
)

(defun create-entity (entityName id entityId sector program programSize position)
  "Create a new entity (issuer) "
  (insert entity-table entityName {
      "userFullname":"agent_1",
      "id": id,
      "entityId": entityId,
      "entityName": entityName,
      "sector": sector,
      "program": program,
      "programSize": programSize,
      "position" : position
      }
  ))

(defun amend-loanAmount (loanId:string loanAmount:integer)
  "Amend a loan : onChangeLoanAmount"
    (update loans-table loanId{
        "loanAmount":loanAmount
    }
  )
  (read loans-table loanId)
)

(defun amend-maturity (loanId:string maturity:time)
  "Amend a loan: Maturity Date"
    (update loans-table loanId{
        "maturityDate": maturity
    }
  )
  (read loans-table loanId)
)

(defun amend-rate (loanId:string rate:decimal)
  "Amend a loan: rate"
    (update loans-table loanId{
        "rate":rate
    }
  )
  (read loans-table loanId)
)

)
