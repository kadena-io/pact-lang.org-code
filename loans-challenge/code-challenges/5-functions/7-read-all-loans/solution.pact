;; ------------------------------------------------
;;              read-all-loans
;; ------------------------------------------------

;; define a function named read-all-loans that takes no parameters
(defun read-all-loans ()
  ;; select all values from the loans-table with constantly set to true
  (select loans-table (constantly true)))
