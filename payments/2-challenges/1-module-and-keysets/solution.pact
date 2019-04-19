;; ========================================================
;;                   1-module-and-keyset
;; ========================================================

;; define and read a keyset named admin-keyset
(define-keyset 'admin-keyset (read-keyset "admin-keyset"))
;; create a module named payments that gives access to admin-keyset
(module payments 'admin-keyset
)
