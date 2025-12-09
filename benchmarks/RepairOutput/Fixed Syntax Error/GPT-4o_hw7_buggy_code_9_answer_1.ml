```ocaml
(*--------------------------------------------------------------*)
(* Q1 : String to Characters to String                  *)
(*--------------------------------------------------------------*)

(* 1.1 Turn a string into a list of characters. *)
let string_explode (s : string) : char list = 
  let rec aux idx acc =
    if idx < 0 then acc
    else aux (idx - 1) (s.[idx] :: acc)
  in
  aux (String.length s - 1) []
;;

(* 1.2 Turn a list of characters into a string. *)
let string_implode (l : char list) : string =
  String.concat "" (List.map Char.escaped l)
;;

(* ------------------------------------------------------------------------*)
(* Q2 : Bank Account *)
(* ------------------------------------------------------------------------*)

type password = string
type bank_account = { mutable pass: password }

let open_account (pass: password) : bank_account =
  { pass }
;;
```