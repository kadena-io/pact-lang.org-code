;; define a function that takes parameters entityName, id, entityId, sector, program, programSize, and position
(defun create-entity (entityName id entityId sector program programSize position)
  "Create a new entity (issuer) "
  ;; insert entityName into entityTable using input parameters
  (insert entity-table entityName {
      ;; userFullname
      "userFullname":"agent_1",
      ;; id
      "id": id,
      ;; entityId
      "entityId": entityId,
      ;; entityName
      "entityName": entityName,
      ;; sector
      "sector": sector,
      ;; program
      "program": program,
      ;; programSize
      "programSize": programSize,
      ;; position
      "position" : position
      }
  ))
