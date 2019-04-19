;; ================================================
;;              1-module-and-keyset
;; ================================================

;; define and read keyset named loans-admin-keyset

;; define module named loans with access given to loans-admin-keyset


;; ================================================
;;              2-define-schemas
;; ================================================

;; ------------------------------------------------
;;                   2.1-loan
;; ------------------------------------------------

;; define schema named loan with the column names and types as shown

    ;; column loanName of type string

    ;; column entityName of type string

    ;; column loanAmount of type integer

    ;; column status of type string



    ;; ------------------------------------------------
    ;;              2.2-loan-history
    ;; ------------------------------------------------

  ;; define schema named loan-history with the column names and types as shown

    ;; column loanId of type string

    ;; column buyer of type string

    ;; column seller of type string

    ;; column amount of type integer



    ;; ------------------------------------------------
    ;;             2.3-loan-inventory
    ;; ------------------------------------------------

  ;; define schema named loan-inventory with the column names and types as shown

    ;; column balance of type integer



  ;; ================================================
  ;;                 3-define-tables
  ;; ================================================

  ;; define a table named loans-table using the loans schema

  ;; define a table named loan-history-table using the loan-history schema

  ;; define a table named loan-inventory-table using the loan-inventory schema



  ;; ================================================
  ;;               4-define-consts
  ;; ================================================

  ;; define constant named INITIATED including comment "initiated"

  ;; define constant named ASSIGNED including comment "assigned"


  ;; ================================================
  ;;               5-define-functions
  ;; ================================================
    ;; Create each of the following functions as described in the sections below.

  ;; ------------------------------------------------
  ;;               5.1-inventory-key
  ;; ------------------------------------------------

  ;; define a function named inventory-key that takes inputs loanId:string and owner:string

     ;; format a composite key from OWNER and LoanId in the format "loanId:owner"



  ;; ------------------------------------------------
  ;;               5.2-create-a-loan
  ;; ------------------------------------------------

  ;; define a function named create-a-loan that takes the parameters loanId, loanName, entityName, and loanAmount

    ;; insert data into loans-table using the loanId

      ;; insert "loanName" as value of loanName

      ;; insert "entityName" as value of entityName

      ;; insert "loanAmount" as value of loanAmount

      ;; insert "status" as value INITIATED


    ;; insert to loan inventory table with the parameters inventory-key, loanId, and entity name

      ;; insert "balance" as value loanAmount



  ;; ------------------------------------------------
  ;;              5.3-assign-a-loan
  ;; ------------------------------------------------

  ;; define a function named assign-a-loan that takes parameters txid, loanId, buyer, and amount

    ;; read from loans-table using loanId

      ;; bind "entityName" to the value of entityName

      ;; bind "loanAmount" to the value of issuerBalance


      ;;insert into loan-history-table using the value of txid

        ;; insert "loanId" as value of loanId

        ;; insert "buyer" as value of buyer

        ;; insert "seller" as value of entityName

        ;; insert "amount" as value of amount


      ;; insert to loan-inventory-table with the parameters inventory-key, loanId, and buyer

        ;; insert "balance" as value of amount


      ;; update loan-inventory-table with the parameters inventory-key, loanId, and entityName

        ;; update new balance of the issuer in the inventory table


      ;; update loans-table using loanId

        ;; update "status" to value ASSIGNED



  ;; ------------------------------------------------
  ;;               5.4-sell-a-loan
  ;; ------------------------------------------------

  ;; define a function named sell-a-loan that takes parameters txid, loanId, buyer, seller, and amount

    ;; read from loan-inventory-table using paramters inventory-key, loanId, and seller

      ;; bind "balance" to value of prev-seller-balance

      ;; read from loan-inventory-table with parameters inventory-key, loanId, and buyer

        ;; assign "balance" to 0

        ;; bind "balance" to value of prev-buyer-balance

      ;; insert to loan-history-table at the given txid

        ;; insert "loanId" as value of loanId

        ;; insert "buyer" as value of buyer

        ;; insert "seller" as value of seller

        ;; insert "amount" as value of amount


      ;; update the loan-inventory-table with parameters inventory-key, loanId, and seller

        ;; set "balance" the previous-seller-balance minus the amount

      ;; write to the loan-inventory-table with parameters inventory-key, loanId, and buyer

        ;; set "balance" the previous-seller-balance plus the amount


  ;; ------------------------------------------------
  ;;              5.5-read-a-loan
  ;; ------------------------------------------------

  ;; define a function named read-a-loan that takes parameter loanId

  ;; read all values of the loans-table at the given loanId


  ;; ------------------------------------------------
  ;;             5.6-read-loan-tx
  ;; ------------------------------------------------

  ;; define a function named read-loan-tx that takes no parameters

    ;; map the values of the transaction log in the loans table to the txids in the loans table at value 0


  ;; ------------------------------------------------
  ;;              5.7-read-all-loans
  ;; ------------------------------------------------

  ;; define a function named read-all-loans that takes no parameters

    ;; select all values from the loans-table with constantly set to true


  ;; ------------------------------------------------
  ;;              5.8-read-inventory-pair
  ;; ------------------------------------------------

  ;; define a function named read-inventory-pair that takes a parameter named key

    ;; set "inventory-key" to the provided key

     ;; set "balance" the value of the balance of loan-inventory-table at the value of the key



  ;; ------------------------------------------------
  ;;            5.9-read-loan-inventory
  ;; ------------------------------------------------

  ;; define a function named read-loan-inventory that takes no parameters

    ;; map the value of read-inventory-pair to the keys of the loan-inventory-table


  ;; ------------------------------------------------
  ;;          5.10-read-loans-with-status
  ;; ------------------------------------------------

  ;; define a function named read-loans-with-status that takes the parameter status

    ;; select all values from the loans-table where "status" equals the parameter status



;; ================================================
;;                 6-create-tables
;; ================================================

;; create loans-table

;; create loans-history-table

;; create loans-inventory-table
