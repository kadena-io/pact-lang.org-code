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
        (if (> balance amount)
          ;;If condition is true, update my-coin-table
          (update my-coin-table account
            { "balance" : (- balance amount) })
          ;;If condition is false, print message
          "Balance is not sufficient for transfer" )))

  ;; refactor with enforce
  (defun debit:string (account:string amount:decimal)
    @doc "Debit AMOUNT from ACCOUNT balance recording DATE and DATA"
      (with-read my-coin-table account
        { "balance" := balance }
        ;; Enforce the condition, and fail transaction if condition doesn't meet.
        (enforce (> balance amount) "Balance is not sufficient for transfer")
        ;;Update the balance.
        (update my-coin-table account
          { "balance" : (- balance amount) })))

  ;;TEMPTING USE of "IF" (type 2)
  (defun credit-if:string (account:string keyset:keyset amount:decimal)
    @doc "Credit AMOUNT to ACCOUNT balance recording DATE and DATA"

   ;; Fetch all keys in my-coin-table and see if account exists.
   (if (contains account (keys my-coin-table))

    ;;if the row exists, check keyset and update the balance
    (with-read my-coin-table account { "balance":= balance,
                                       "keyset":= retk }
       ;;If the keysets do match, update the balance.
       ;;Otherwise, print error message.
       (if (= retk keyset)
         (update my-coin-table account {
           "balance": (+ amount balance)})
         "The keysets do not match" ))

    ;;if the row does not exist, insert a row into the table.
    (insert my-coin-table account{
       "balance": amount,
       "keyset": keyset
      })))

  ;;refactor with with-default-read & write & enforce
  (defun credit:string (account:string keyset:keyset amount:decimal)
    @doc "Credit AMOUNT to ACCOUNT balance recording DATE and DATA"

    ;;Default the row to balance at 0.0 and keyset at input keyset
    ;;If row exists, then bind balance and keyset value from the table.
    ;;This allows one time key lookup - increases efficiency.
    (with-default-read my-coin-table account
      { "balance": 0.0, "keyset": keyset }
      { "balance":= balance, "keyset":= retg }
      ;;Check that the input keyset is the same as the row's keyset
      (enforce (= retg keyset)
        "account guards do not match")
      ;;Writes the row to the table. (write adds  the table with the key and the row.
      (write my-coin-table account
        { "balance" : (+ balance amount)
        , "keyset"   : retg
        })))
)

(create-table my-coin-table)
