;; ------------------------------------------------
;;          read-loans-with-status
;; ------------------------------------------------

;; define a function named read-loans-with-status that takes the parameter status
(defun read-loans-with-status (status)
  ;; select all values from the loans-table where "status" equals the parameter status
  (select loans-table (where "status" (= status))))
)
