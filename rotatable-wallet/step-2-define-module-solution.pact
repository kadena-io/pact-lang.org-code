(define-keyset 'module-admin
  (read-keyset "module-admin-keyset"))

(define-keyset 'operate-admin
  (read-keyset "module-operate-keyset"))

;; 1. create module named auth with access given to module-admin
(module auth 'module-admin

)
