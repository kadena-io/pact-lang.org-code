;; ========================================================
;;                   2-define-schemas-and-table
;; ========================================================

  ;; define the schema for payments including balance as type decimal and keyset as type keyset
  (defschema payments
    balance:decimal
    keyset:keyset)
  ;; define the payments-table using the schema {payments} created above
  (deftable payments-table:{payments})
