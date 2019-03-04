;; --------------------------------------------------------
;;              Step 1: DEFINE KEYSETS
;; --------------------------------------------------------

;; 1. define and read module-admin keyset

;; 2. define and read operate-admin keyset

module auth `module-admin()

;; --------------------------------------------------------
;;              Step 2: DEFINE MODULE
;; --------------------------------------------------------

;; 1. create module named auth with access given to module-admin

  ;; --------------------------------------------------------
  ;;             Step 3: DEFINE SCHEMA AND TABLE
  ;; --------------------------------------------------------

  ;; 1. define schema user including nickname as type string and keyset as type keyset

  ;; 2. define table named users with user schema

  ;; 3. create table named users outside of module

  ;; --------------------------------------------------------
  ;;              Step 4: FUNCTION create-user
  ;; --------------------------------------------------------

  ;; 1. Define a function create-user that takes arguments id, nickname, and keyset

    ;; 2. Enforce access to restrict function calls to the operate-admin

    ;; 3. Insert a row into the users table at the given id, keyset, and nickname

  ;; --------------------------------------------------------
  ;;             Step 5: FUNCTION enforce-user-auth
  ;; --------------------------------------------------------

  ;; 1. Define a function enforce-user-auth that takes a parameter (id)

    ;; 2. Read users table to find id then bind value k equal this id's keyset

    ;; 3. Enforce user authorization of data to the given keyset

    ;; 4. Return the value of the keyset

  ;; --------------------------------------------------------
  ;;            Step 6: FUNCTION change-nickname
  ;; --------------------------------------------------------

  ;; 1. Define a function change-nickname that takes parameters id and new-name

    ;; 2. Enforce user authorization to the id provided

    ;; 3. Update the users nickname to the new-name using the given id

    ;; 4. Return a message to the user formatted as "Updated name for user [id] to [name]"

  ;; --------------------------------------------------------
  ;;            Step 7: FUNCTION rotate-keyset
  ;; --------------------------------------------------------

  ;; Define a function rotate-keyset that takes the parameters id and new-keyset

    ;; Enforce user authorization to the provided id.

    ;; Update the keyset to the new-keyset for the id in the users table.

    ;; Return a message describing the update in the format "Updated keyset for user [id]".
