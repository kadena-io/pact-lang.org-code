;; ------------------------------------------------
;;              read-inventory-pair
;; ------------------------------------------------

;; define a function named read-inventory-pair that takes a parameter named key
(defun read-inventory-pair (key)
  ;; set "inventory-key" to the provided key
  {"inventory-key":key,
   ;; set "balance" the value of the balance of loan-inventory-table at the value of the key
   "balance": (at 'balance (read loan-inventory-table key))}
  )
