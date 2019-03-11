;; Step 2 code goes here
  (defschema payments
    balance:decimal
    keyset:keyset)

  (deftable payments-table:{payments})
