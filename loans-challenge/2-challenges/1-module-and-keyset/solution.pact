;; ================================================
;;               Module and Keyset
;; ================================================

;; define and read keyset named loans-admin-keyset
(define-keyset 'loans-admin-keyset (read-keyset "loans-admin-keyset"))
;; define module named loans with access given to loans-admin-keyset
(module loans 'loans-admin-keyset

)
