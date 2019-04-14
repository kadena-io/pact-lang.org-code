;; ------------------------------------------------
;;              read-a-loan
;; ------------------------------------------------

;; define a function named read-a-loan that takes parameter loanId
(defun read-a-loan (loanId)
;; read all values of the loans-table at the given loanId
  (read loans-table loanId))
