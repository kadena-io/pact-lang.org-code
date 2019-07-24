;;
;; "Hello, world!" smart contract/module
;;

(define-keyset 'admin-keyset (read-keyset "admin-keyset"))

;; Define the module.
(module hello 'admin-keyset
 "A smart contract to greet the world."
 (defun hello (name)
   "Do the hello-world dance"
   (format "Hello {}!" [name]))
)
