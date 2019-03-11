  (defun create-loan (entityName cusip userFullname loanName
    loanAmount maturityDate utilization paymentFrequency
    reference rating attachments rate)
    "Create a new loan"
    ;; read loan-id tracker field NEXT-LOANID
    (with-read loanId-tracker NEXT-LOANID
    ;; bind loanId to valud id
      { "loanId" := id }
    ;; update loanId-tracker table with NEXT-LOANID
    (update loanId-tracker NEXT-LOANID
      { "loanId": (+ id 1) })
    ;; read entityName from entity-table
    (with-read entity-table entityName{
      ;; bind "sector" to value from column sector in entity-table
      "sector":= sector,
      ;; bind "program" to value from column program in entity-table
      "program":= program,
      ;; bind "programSize" to value from column programSize in entity-table
      "programSize":= programSize,
      ;; bind "entityId" to value from column entityId in entity-table
      "entityId":= entityId,
      ;; bind "position" to value from column position in entity-table
      "position":= position
    }
    ;; create variable "row" and assign it all variables to add to loans-table
    (let (
      (row {
        ;; assign "userFullname" to value of userFullname
        "userFullname": userFullname,
        ;; assign "loanId" to a formatted value of "B-3834431467-[id]"
        "loanId": (format "B-3834431467-{}" [id]),
        ;; assign "cusip" to value of cusip
        "cusip": cusip,
        ;; assign "entityId" to value of entityId
        "entityId": entityId,
        ;; assign "entityName" to value of entityName
        "entityName": entityName,
        ;; assign "loanAmount" to value of loanAmount
        "loanAmount": loanAmount,
        ;; assign "sector" to value of sector
        "sector": sector,
        ;; assign "program" to value of program
        "program": program,
        ;; assign "programSize" to value of programSize
        "programSize": programSize,
        ;; assign "loanName" to value of loanName
        "loanName": loanName,
        ;; assign "maturityDate" to value of maturityDate
        "maturityDate": maturityDate,
        ;; assign "rate" to value of rate
        "rate": rate,
        ;; assign "position" to value of position
        "position": position,
        ;; assign "utilization" to value of utilization
        "utilization": utilization,
        ;; assign "rating" to value of rating
        "rating": rating,
        ;; assign "attachments" to value of attachments
        "attachments": attachments,
        ;; assign "paymentFrequency" to value of paymentFrequency
        "paymentFrequency": paymentFrequency,
        ;; assign "reference" to value of reference
        "reference": reference,
        ;; assign "assigned" to value of INITIATED
        "assigned": INITIATED,
        ;; assign "amendment" to value of {}
        "amendment": {}
      })
      )
      ;; insert row into loans-table in format (format "B-3834431467-[id]" )
      ;; NOTE: The variable row is saved as an object
      (insert loans-table (format "B-3834431467-{}" [id]) row)
      ;; return value of row
      row
    )))
  )



  ;; Define a function create-asset that takes parameter assetFullName
  (defun create-asset (assetFullName)
    "Create a new asset"
    ;; read asset-id tracker field NEXT-ASSETID
    (with-read assetId-tracker NEXT-ASSETID
    ;; bind assetID to value id
      { "assetId" := id }
    ;; update loanId-tracker table with NEXT-LOANID
    (update assetId-tracker NEXT-ASSETID
      { "assetId": (+ id 1) })
    ;; read assetName from asset-table
    (with-read asset-table assetName {
      ;; bind "fullName" to value from column assetFullName in asset-table
      "fullName":= assetFullName
    }
    ;; create variable "row" and assign it all variables to add to loans-table
    (let (
      (row {
        ;; assign "assetId" to a formatted value of "A-12345-[id]"
        "assetId": (format "A-12345-{}" [id])
        ;; assign "userFullname" to value of userFullname
        "assetFullName": assetFullName,
      })
      )
      ;; insert row into loans-table in format (format "A-12345-[id]" )
      (insert asset-table (format "B-3834431467-{}" [id]) row)
      ;; return value of row
      row
    )))
  )
