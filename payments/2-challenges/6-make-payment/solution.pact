;; ========================================================
;;                        6-make-payment
;; ========================================================

;; do payment of 25.0 from Sarah to James
(pay "Sarah" "James" 25.0)

;; read Sarah's balance as Sarah
(format "Sarah's balance is {}" [(get-balance "Sarah")])

;; read James' balance as JAMES
(format "James's balance is {}" [(get-balance "James")])
