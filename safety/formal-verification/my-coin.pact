(define-keyset 'coin-admin-keyset
  (read-keyset 'coin-admin-keyset))

(module my-coin 'coin-admin-keyset
  @doc "'my-coin' represents the Kadena Coin Contract. This contract provides both the \
  \buy/redeem gas support in the form of 'fund-tx', as well as transfer,       \
  \credit, debit, coinbase, account creation and query, as well as SPV burn    \
  \create. To access the coin contract, you may use its fully-qualified name,  \
  \or issue the '(use coin)' command in the body of a module declaration."
  ; --------------------------------------------------------------------------
  ; Properties
  @model[
    (defproperty conserves-mass
      (= (column-delta coin-table 'balance) 0.0))
    ]


  ; --------------------------------------------------------------------------
  ; Schemas and Tables

  (defschema coin-schema
    @doc "my-coin account with balances and guards"
    ;; Schema invariant to ensure balance is greater than or equal to 0.0
    @model [(invariant (> balance 0.0))]
    balance:decimal
    guard:guard)

  (deftable coin-table:{coin-schema})

  ; --------------------------------------------------------------------------
  ; Module guard

  (defun my-coin-guard:guard ()
    (create-module-guard 'my-coin-guard))

  ; --------------------------------------------------------------------------
  ; Capabilities

  (defcap TRANSFER ()
    "Autonomous capability to protect debit and credit actions"
    true)

  (defcap ACCOUNT_GUARD (account)
    "Lookup and enforce guards associated with an account"
    (with-read coin-table account { "guard" := g }
      (enforce-guard g)))

  ; --------------------------------------------------------------------------
  ; Coin Contract

  (defun create-account:string (account:string guard:guard)
    (enforce-guard (my-coin-guard))
    (insert coin-table account
      { "balance" : 0.0
      , "guard"   : guard
      })
    )

  (defun transfer:string (sender:string receiver:string receiver-guard:guard amount:decimal)
    @doc "Debit AMOUNT from the sender's ACCOUNT and credit AMOUNT the receiver's ACCOUNT"
    @model [ (property (> amount 0.0))
             (property (not (= sender receiver)))
             (property conserves-mass)
             ]
    ;; Property threw warning of a case sender and receiver are the same,
    ;; so add enforce statements to prevent it.
    (enforce-guard receiver-guard)
    (enforce (not (= sender receiver))
      "sender cannot be the receiver of a transfer")

    (enforce (> amount 0.0)
      "transfer amount must be positive")

    (with-capability (TRANSFER)
      (debit sender amount)
      (credit receiver receiver-guard amount))
    )


  (defun debit:string (account:string amount:decimal)
    @doc "Debit AMOUNT from ACCOUNT balance"
    ;; Property that the debit amount is a positive value

    @model [ (property (> amount 0.0)) ]

    ;;Add enforce statement that satisfies the property.
    (enforce (> amount 0.0)
      "debit amount must be positive")

    (require-capability (TRANSFER))
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
    ;; Property that the debit amount is a positive value
    ;; Also checks that account is not an empty string.
    @model [ (property (> amount 0.0))]

    ;;Add enforce statement that satisfies the property.
     (enforce (> amount 0.0)
       "credit amount must be positive")

    (require-capability (TRANSFER))
    (with-default-read coin-table account
      { "balance" : 0.0, "guard" : guard }
      { "balance" := balance, "guard" := retg }
      (enforce (= retg guard)
        "account guards do not match")
      (write coin-table account
        { "balance" : (+ balance amount)
        , "guard"   : retg
        })
      ))
)

(create-table coin-table)
