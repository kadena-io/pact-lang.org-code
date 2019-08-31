(define-keyset 'coin-admin-keyset
  (read-keyset 'coin-admin-keyset))

(module my-coin 'coin-admin-keyset

  "'my-coin' represents a simple ledger system. It provides transfer, credit, \
  \debit, account creation and querying. "

  ; --------------------------------------------------------------------------
  ; Schemas and Tables

  (defschema my-coin-schema
    balance:decimal
    keyset:keyset)

  (deftable my-coin-table:{my-coin-schema})

  ; --------------------------------------------------------------------------
  ; My Coin Contract

  (defun account-balance (account:string)
    (with-read my-coin-table account
     { "balance" := balance }
     balance
     )
  )

  (defun create-account:string (account:string keyset:keyset)
    (insert my-coin-table account
      { "balance" : 0.0
      , "keyset" : keyset
      })
    )

  ;; Debit using if
  (defun debit-if:string (account:string amount:decimal)
    @doc "Debit AMOUNT from ACCOUNT balance recording DATE and DATA"
      (with-read my-coin-table account
        { "balance" := balance }
        ;;Check if balance is sufficient for the transfer
          ;;STEP 1: UNSAFE IF STATEMENT GOES HERE
          ;;STEP 2: If condition is true, update my-coin-table


          ;;STEP 3:If condition is false, print message

          )

  ;; refactor with enforce
  (defun debit:string (account:string amount:decimal)
    @doc "Debit AMOUNT from ACCOUNT balance recording DATE and DATA"
      (with-read my-coin-table account
        { "balance" := balance }
        ;; STEP 1: Enforce the condition, and fail transaction if condition doesn't meet.

        ;; STEP 2: Update the balance.


          )

  ;;TEMPTING USE of "IF" (type 2)
  (defun credit-if:string (account:string keyset:keyset amount:decimal)
    @doc "Credit AMOUNT to ACCOUNT balance recording DATE and DATA"

   ;; STEP 1: Fetch all keys in my-coin-table and see if account exists.


    ;; STEP 2: if the row exists, check keyset and update the balance


       ;;STEP 3: If the keysets do match, update the balance.
       ;;Otherwise, print error message.





    ;; STEP 4: if the row does not exist, insert a row into the table.



      ))

  ;;refactor with with-default-read & write & enforce
  (defun credit:string (account:string keyset:keyset amount:decimal)
    @doc "Credit AMOUNT to ACCOUNT balance recording DATE and DATA"

    ;;STEP 1: Default the row to balance at 0.0 and keyset at input keyset
    ;;If row exists, then bind balance and keyset value from the table.
    ;;This allows one time key lookup - increases efficiency.
    


      ;;STEP 2: Check that the input keyset is the same as the row's keyset


      ;; STEP 3: Writes the row to the table. (write adds  the table with the key and the row.




)

(create-table my-coin-table)
