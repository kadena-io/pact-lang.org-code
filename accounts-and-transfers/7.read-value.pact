;; pay 25.0 from Sarah's account to James' acount.
(pay "Sarah" "James" 25.0)
;; read new balance for sarah
(format "Sarah's balance is {}" [(get-balance "Sarah")])
;; read new balance for james
(format "James's balance is {}" [(get-balance "James")])
