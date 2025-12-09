(*--------------------------------------------------------------*)
(* Q1 : String to Characters to String                  *)
(*--------------------------------------------------------------*)

(* 1.1 Turn a string into a list of characters. *)
let string_explode (s : string) : char list = 
  tabulate (String.get(s)) (String.length(s));;

      
(* 1.2 Turn a list of characters into a string. *)
let string_implode (l : char list) : string =
  List.fold_left (^) ("") (List.map(Char.escaped)(l))

(* ------------------------------------------------------------------------*)
(* Q2 : Bank Account *)
(* ------------------------------------------------------------------------*)

let open_account (pass: password) : bank_account =
  {
    updated_pass(pass)
  }
;;

