(defun get-balance (id)
  "Only users or admin can read balance."
  (with-read payments-table id
    { "balance":= balance, "keyset":= keyset }
    (enforce-one "Access denied"
      [(enforce-keyset keyset)
       (enforce-keyset 'admin-keyset)])
    balance))
