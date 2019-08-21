(interface coin-sig

  "'coin-sig' represents the My Coin Contract interface. This contract     \
  \provides both the the general interface for a Kadena's token, supplying a   \
  \transfer function, account creation and balance query."

  (defconst MODULE_GUARD 'my-coin-guard)
  (defun create-account:string (account:string guard:guard)
    @doc "Create an account for ACCOUNT, with ACCOUNT as a function of GUARD"
    @model [ (property (not (= account ""))) ]
    )

  (defun transfer:string (sender:string receiver:string receiver-guard:guard amount:decimal)
    @doc "Debit AMOUNT from the sender's ACCOUNT and credit AMOUNT the receiver's ACCOUNT"
    @model [ (property (> amount 0.0))
             (property (not (= sender receiver)))
           ]
    )
  (defun debit:string (account:string amount:decimal)
    @doc "Debit AMOUNT from ACCOUNT balance"
    @model [ (property (> amount 0.0)) ]
  )

  (defun credit:string (account:string guard:guard amount:decimal)
    @doc "Credit AMOUNT to ACCOUNT balance"
    @model [ (property (> amount 0.0))])
  )
