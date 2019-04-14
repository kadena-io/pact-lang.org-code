;; ================================================
;;                  Define Tables
;; ================================================

;; define a table named loans-table using the loans schema
(deftable loans-table:{loan})
;; define a table named loan-history-table using the loan-history schema
(deftable loan-history-table:{loan-history})
;; define a table named loan-inventory-table using the loan-inventory schema
(deftable loan-inventory-table:{loan-inventory})
