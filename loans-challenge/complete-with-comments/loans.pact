;; ================================================
;;               Module and Keyset
;; ================================================

;; define and read keyset named loans-admin-keyset
(define-keyset 'loans-admin-keyset (read-keyset "loans-admin-keyset"))
;; define module named loans with access given to loans-admin-keyset
(module loans 'loans-admin-keyset

;; ================================================
;;               Define Schemas
;; ================================================

;; ------------------------------------------------
;;                    1-loan
;; ------------------------------------------------

;; define schema named loan with the column names and types as shown
  (defschema loan
    ;; column loanName of type string
    loanName:string
    ;; column entityName of type string
    entityName:string
    ;; column loanAmount of type integer
    loanAmount:integer
    ;; column status of type string
    status:string
    )

    ;; ------------------------------------------------
    ;;               2-loan-history
    ;; ------------------------------------------------

  ;; define schema named loan-history with the column names and types as shown
  (defschema loan-history
    ;; column loanId of type string
    loanId:string
    ;; column buyer of type string
    buyer:string
    ;; column seller of type string
    seller:string
    ;; column amount of type integer
    amount:integer
    )

    ;; ------------------------------------------------
    ;;              3-loan-inventory
    ;; ------------------------------------------------

  ;; define schema named loan-inventory with the column names and types as shown
  (defschema loan-inventory
    ;; column balance of type integer
    balance:integer
    )

  ;; ================================================
  ;;                  Define Tables
  ;; ================================================

  ;; define a table named loans-table using the loans schema
  (deftable loans-table:{loan})
  ;; define a table named loan-history-table using the loan-history schema
  (deftable loan-history-table:{loan-history})
  ;; define a table named loan-inventory-table using the loan-inventory schema
  (deftable loan-inventory-table:{loan-inventory})


  ;; ================================================
  ;;               Define Consts
  ;; ================================================

  ;; define constant named INITIATED including comment "initiated"
  (defconst INITIATED "initiated")
  ;; define constant named ASSIGNED including comment "assigned"
  (defconst ASSIGNED "assigned")

  ;; ================================================
  ;;               Define Functions
  ;; ================================================
    ;; Create each of the following functions as described in the sections below.

  ;; ------------------------------------------------
  ;;               inventory-key
  ;; ------------------------------------------------

  ;; define a function named inventory-key that takes inputs loanId:string and owner:string
  (defun inventory-key (loanId:string owner:string)
     ;; format a composite key from OWNER and LoanId in the format "loanId:owner"
     (format "{}:{}" [loanId owner])
   )

  ;; ------------------------------------------------
  ;;               create-a-loan
  ;; ------------------------------------------------

  ;; define a function named create-a-loan that takes the parameters loanId, loanName, entityName, and loanAmount
  (defun create-a-loan (loanId loanName entityName loanAmount)
    ;; insert data into loans-table using the loanId
    (insert loans-table loanId {
      ;; insert "loanName" as value of loanName
      "loanName":loanName,
      ;; insert "entityName" as value of entityName
      "entityName":entityName,
      ;; insert "loanAmount" as value of loanAmount
      "loanAmount":loanAmount,
      ;; insert "status" as value INITIATED
      "status":INITIATED
      })
    ;; insert to loan inventory table with the parameters inventory-key, loanId, and entity name
    (insert loan-inventory-table (inventory-key loanId entityName){
      ;; insert "balance" as value loanAmount
      "balance": loanAmount
      }))

  ;; ------------------------------------------------
  ;;              assign-a-loan
  ;; ------------------------------------------------

  ;; define a function named assign-a-loan that takes parameters txid, loanId, buyer, and amount
  (defun assign-a-loan (txid loanId buyer amount)
    ;; read from loans-table using loanId
    (with-read loans-table loanId {
      ;; bind "entityName" to the value of entityName
      "entityName":= entityName,
      ;; bind "loanAmount" to the value of issuerBalance
      "loanAmount":= issuerBalance
      }
      ;;insert into loan-history-table using the value of txid
      (insert loan-history-table txid {
        ;; insert "loanId" as value of loanId
        "loanId":loanId,
        ;; insert "buyer" as value of buyer
        "buyer":buyer,
        ;; insert "seller" as value of entityName
        "seller":entityName,
        ;; insert "amount" as value of amount
        "amount": amount
        })
      ;; insert to loan-inventory-table with the parameters inventory-key, loanId, and buyer
      (insert loan-inventory-table (inventory-key loanId buyer) {
        ;; insert "balance" as value of amount
        "balance":amount
        })
      ;; update loan-inventory-table with the parameters inventory-key, loanId, and entityName
      (update loan-inventory-table (inventory-key loanId entityName){
        ;; update new balance of the issuer in the inventory table
        "balance": (- issuerBalance amount)
        }))
      ;; update loans-table using loanId
      (update loans-table loanId {
        ;; update "status" to value ASSIGNED
        "status": ASSIGNED
        }))

  ;; ------------------------------------------------
  ;;               sell-a-loan
  ;; ------------------------------------------------

  ;; define a function named sell-a-loan that takes parameters txid, loanId, buyer, seller, and amount
  (defun sell-a-loan (txid loanId buyer seller amount)
    ;; read from loan-inventory-table using paramters inventory-key, loanId, and seller
    (with-read loan-inventory-table (inventory-key loanId seller)
      ;; bind "balance" to value of prev-seller-balance
      {"balance":= prev-seller-balance}
      ;; read from loan-inventory-table with parameters inventory-key, loanId, and buyer
      (with-default-read loan-inventory-table (inventory-key loanId buyer)
        ;; assign "balance" to 0
        {"balance" : 0}
        ;; bind "balance" to value of prev-buyer-balance
        {"balance":= prev-buyer-balance}
      ;; insert to loan-history-table at the given txid
      (insert loan-history-table txid {
        ;; insert "loanId" as value of loanId
        "loanId":loanId,
        ;; insert "buyer" as value of buyer
        "buyer":buyer,
        ;; insert "seller" as value of seller
        "seller":seller,
        ;; insert "amount" as value of amount
        "amount": amount
        })
      ;; update the loan-inventory-table with parameters inventory-key, loanId, and seller
      (update loan-inventory-table (inventory-key loanId seller)
        ;; set "balance" the previous-seller-balance minus the amount
        {"balance": (- prev-seller-balance amount)})
      ;; write to the loan-inventory-table with parameters inventory-key, loanId, and buyer
      (write loan-inventory-table (inventory-key loanId buyer)
        ;; set "balance" the previous-seller-balance plus the amount
        {"balance": (+ prev-buyer-balance amount)}))))

  ;; ------------------------------------------------
  ;;              read-a-loan
  ;; ------------------------------------------------

  ;; define a function named read-a-loan that takes parameter loanId
  (defun read-a-loan (loanId)
  ;; read all values of the loans-table at the given loanId
    (read loans-table loanId))

  ;; ------------------------------------------------
  ;;             read-loan-tx
  ;; ------------------------------------------------

  ;; define a function named read-loan-tx that takes no parameters
  (defun read-loan-tx ()
    ;; map the values of the transaction log in the loans table to the txids in the loans table at value 0
    (map (txlog loans-table) (txids loans-table 0)))

  ;; ------------------------------------------------
  ;;              read-all-loans
  ;; ------------------------------------------------

  ;; define a function named read-all-loans that takes no parameters
  (defun read-all-loans ()
    ;; select all values from the loans-table with constantly set to true
    (select loans-table (constantly true)))

  ;; ------------------------------------------------
  ;;              read-inventory-pair
  ;; ------------------------------------------------

  ;; define a function named read-inventory-pair that takes a parameter named key
  (defun read-inventory-pair (key)
    ;; set "inventory-key" to the provided key
    {"inventory-key":key,
     ;; set "balance" the value of the balance of loan-inventory-table at the value of the key
     "balance": (at 'balance (read loan-inventory-table key))}
    )

  ;; ------------------------------------------------
  ;;            read-loan-inventory
  ;; ------------------------------------------------

  ;; define a function named read-loan-inventory that takes no parameters
  (defun read-loan-inventory ()
    ;; map the value of read-inventory-pair to the keys of the loan-inventory-table
    (map (read-inventory-pair) (keys loan-inventory-table)))

  ;; ------------------------------------------------
  ;;          read-loans-with-status
  ;; ------------------------------------------------

  ;; define a function named read-loans-with-status that takes the parameter status
  (defun read-loans-with-status (status)
    ;; select all values from the loans-table where "status" equals the parameter status
    (select loans-table (where "status" (= status))))
  )

;; ================================================
;;               Create Tables
;; ================================================

;; create loans-table
(create-table loans-table)
;; create loans-history-table
(create-table loan-history-table)
;; create loans-inventory-table
(create-table loan-inventory-table)
