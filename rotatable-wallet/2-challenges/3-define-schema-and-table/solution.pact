;; ========================================================
;;             3-define-schema-and-table
;; ========================================================

  ;; define schema user including nickname as type string and keyset as type keyset
  (defschema user
    nickname:string
    keyset:keyset
  )
  ;; define table named users with user schema
  (deftable users:{user})
