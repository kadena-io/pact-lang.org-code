;; ========================================================
;;                    2.1-use-auth
;; ========================================================

;; use the auth module
(use auth)
;; --------------------END OF CHALLENGE -------------------

;; define-schemas-and-table
(defschema accounts
  balance:decimal)

(deftable accounts-table:{accounts})
