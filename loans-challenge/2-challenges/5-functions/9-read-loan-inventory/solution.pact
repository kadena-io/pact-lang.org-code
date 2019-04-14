;; ------------------------------------------------
;;            read-loan-inventory
;; ------------------------------------------------

;; define a function named read-loan-inventory that takes no parameters
(defun read-loan-inventory ()
  ;; map the value of read-inventory-pair to the keys of the loan-inventory-table
  (map (read-inventory-pair) (keys loan-inventory-table)))
