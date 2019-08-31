(define-keyset 'coin-admin-keyset
  (read-keyset 'coin-admin-keyset))

(module my-coin 'coin-admin-keyset
  "'coin' represents the Kadena Coin Contract. This contract provides both the \
  \buy/redeem gas support in the form of 'fund-tx', as well as transfer,       \
  \credit, debit, coinbase, account creation and query, as well as SPV burn    \
  \create. To access the coin contract, you may use its fully-qualified name,  \
  \or issue the '(use coin)' command in the body of a module declaration."


  ; --------------------------------------------------------------------------
  ; Schemas and Tables

  (defschema coin-schema
    balance:decimal
    guard:guard)
  (deftable coin-table:{coin-schema})

  ; --------------------------------------------------------------------------
  ; Module guard

  ;; This allows to call (enforce-guard (my-coin-guard)), which protects the code be executed within the module. (enforce-module (my-coin-guard))
  ;; Also allows the module to own asset, by calling (create-account 'module-accout (my-coin-guard))
  (defun my-coin-guard:guard ()
    (create-module-guard 'my-coin-guard))

  ; --------------------------------------------------------------------------
  ; Capabilities

  ;;This capability prevents debit or credit to be called directly.
  ;;Rather, it encapsulatees them into transfer function.
  (defcap TRANSFER ()
    "Autonomous capability to protect debit and credit actions"
    true)

  ;;Finds the account guard and enforces it.
  (defcap ACCOUNT_GUARD (account)
    "Lookup and enforce guards associated with an account"
    (with-read coin-table account { "guard" := g }
      (enforce-guard g)))

  ; --------------------------------------------------------------------------
  ; Coin Contract

  (defun create-account:string (account:string guard:guard)
    ;;Enforces that the function is called within the my-coin module. 
    (enforce-guard (my-coin-guard))
    (insert coin-table account
      { "balance" : 0.0
      , "guard"   : guard
      })
    )

  (defun transfer:string (sender:string receiver:string receiver-guard:guard amount:decimal)
    @doc "Debit AMOUNT from the sender's ACCOUNT and credit AMOUNT the receiver's ACCOUNT"
    ;; Finds the capability TRANSFER, and sets it into the environment.
    (with-capability (TRANSFER)
      (debit sender amount)
      (credit receiver receiver-guard amount))
    )


  (defun debit:string (account:string amount:decimal)
    @doc "Debit AMOUNT from ACCOUNT balance"
    ;; Checks if TRANSFER is within the environment
    (require-capability (TRANSFER))
    ;; Finds if ACCOUNT_GUARD capability is valid, and sets it into the environment
    (with-capability (ACCOUNT_GUARD account)
      (with-read coin-table account
        { "balance" := balance }
        (enforce (<= amount balance) "Balance is not sufficient for transfer")
        (update coin-table account
          { "balance" : (- balance amount) }
          )))
    )


  (defun credit:string (account:string guard:guard amount:decimal)
    @doc "Credit AMOUNT to ACCOUNT balance"
    ;; Checks if TRANSFER is within the environment
    (require-capability (TRANSFER))
    (with-default-read coin-table account
      { "balance" : 0.0, "guard" : guard }
      { "balance" := balance, "guard" := retg }
      ; we don't want to overwrite an existing guard with the user-supplied one
      (enforce (= retg guard)
        "account guards do not match")
      (write coin-table account
        { "balance" : (+ balance amount)
        , "guard"   : retg
        })
      ))
)

(create-table coin-table)
