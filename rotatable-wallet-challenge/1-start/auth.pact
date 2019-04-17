;; ========================================================
;;                    1-define-keysets
;; ========================================================

  ;; define and read module-admin keyset



  ;; define and read operate-admin keyset



;; ========================================================
;;                    2-define-module
;; ========================================================

;; create module named auth with access given to module-admin


  ;; ========================================================
  ;;             3-define-schema-and-table
  ;; ========================================================

  ;; define schema user including nickname as type string and keyset as type keyset




  ;; define table named users with user schema


  ;; ========================================================
  ;;                      4-functions
  ;; ========================================================

  ;; --------------------------------------------------------
  ;;                    4.1-create-user
  ;; --------------------------------------------------------

  ;; define a function create-user that takes arguments id, nickname, and keyset

    ;; enforce access to restrict function calls to the operate-admin

    ;; insert a row into the users table at the given id, keyset, and nickname





  ;; --------------------------------------------------------
  ;;                4.2-enforce-user-auth
  ;; --------------------------------------------------------

  ;; define a function enforce-user-auth that takes a parameter (id)

    ;; read users table to find id then bind value k equal this id's keyset

    ;; enforce user authorization of data to the given keyset

    ;; return the value of the keyset


  ;; --------------------------------------------------------
  ;;                 4.3-change-nickname
  ;; --------------------------------------------------------

  ;; define a function change-nickname that takes parameters id and new-name

    ;; enforce user authorization to the id provided

    ;; update the users nickname to the new-name using the given id

    ;; return a message to the user formatted as "Updated name for user [id] to [name]"



  ;; --------------------------------------------------------
  ;;                 4.4-rotate-keyset
  ;; --------------------------------------------------------

  ;; define a function rotate-keyset that takes the parameters id and new-keyset

    ;; enforce user authorization to the provided id.

    ;; update the keyset to the new-keyset for the id in the users table.

    ;; return a message describing the update in the format "Updated keyset for user [id]".





;; ========================================================
;;                      5-create-table
;; ========================================================

;; create the users table
