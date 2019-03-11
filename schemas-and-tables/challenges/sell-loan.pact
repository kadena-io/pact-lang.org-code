;; ===============================================
;;      Step 1: Define the function and parameters
;; ===============================================

  (defun create-loan ()
    "Create a new loan"

;; ===============================================
;;          Step 2: Create a unique ID
;; ===============================================

    ;; read loan-id-tracker field NEXT-LOANID

    ;; bind loanId to value id

    ;; update loanId-tracker table with NEXT-LOANID

;; ===============================================
;;          Step 3: Bind name to variable
;; ===============================================

    ;; read entityName from entity-table

      ;; bind "sector" to value from column sector in entity-table

      ;; bind "program" to value from column program in entity-table

      ;; bind "programSize" to value from column programSize in entity-table

      ;; bind "entityId" to value from column entityId in entity-table

      ;; bind "position" to value from column position in entity-table

    }

;; ===============================================
;;       Step 4: Create row to add to table
;; ===============================================

       ;; create variable "row" and assign it all variables to add to loans-table
    (let (
             (row {
        ;; assign "userFullname" to value of userFullname

        ;; assign "loanId" to a formatted value of "B-3834431467-[id]"

        ;; assign "cusip" to value of cusip

        ;; assign "entityId" to value of entityId

        ;; assign "entityName" to value of entityName

        ;; assign "loanAmount" to value of loanAmount

        ;; assign "sector" to value of sector

        ;; assign "program" to value of program

        ;; assign "programSize" to value of programSize

        ;; assign "loanName" to value of loanName

        ;; assign "maturityDate" to value of maturityDate

        ;; assign "rate" to value of rate

        ;; assign "position" to value of position

        ;; assign "utilization" to value of utilization

        ;; assign "rating" to value of rating

        ;; assign "attachments" to value of attachments

        ;; assign "paymentFrequency" to value of paymentFrequency

        ;; assign "reference" to value of reference

        ;; assign "assigned" to value of INITIATED

        ;; assign "amendment" to value of {}

      })
      )

;; ===============================================
;;          Step 5: Insert row into Table
;; ===============================================

      ;; insert row into loans-table in format (format "B-3834431467-[id]" )

      ;; return value of row

    )))
  )
