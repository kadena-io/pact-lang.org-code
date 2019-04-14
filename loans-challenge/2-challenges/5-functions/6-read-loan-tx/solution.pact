;; ------------------------------------------------
;;             read-loan-tx
;; ------------------------------------------------

;; define a function named read-loan-tx that takes no parameters
(defun read-loan-tx ()
  ;; map the values of the transaction log in the loans table to the txids in the loans table at value 0
  (map (txlog loans-table) (txids loans-table 0)))
