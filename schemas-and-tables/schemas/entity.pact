;; entity schema and table
  (defschema entity
    "Row type for entity"
    id:integer
    sector:string
    entityId:integer
    entityName:string
    program:string
    programSize:integer
    position:integer
    userFullname:string
  )
