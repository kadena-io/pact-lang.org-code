;define keyset to guard module
(define-keyset 'admin-keyset (read-keyset "admin-keyset"))

;define smart-contract code
(module payments 'admin-keyset

)
