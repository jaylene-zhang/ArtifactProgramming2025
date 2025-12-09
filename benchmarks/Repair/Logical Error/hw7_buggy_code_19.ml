(*--------------------------------------------------------------*)
(* Q1 : String to Characters to String                  *)
(*--------------------------------------------------------------*)

(* 1.1 Turn a string into a list of characters. *)
let string_explode (s : string) : char list =
  List.map (fun x -> (String.get s (String.length s - 1)))  (tabulate (fun y -> String.get s) (String.length s))
  
  
(* 1.2 Turn a list of characters into a string. *)
let string_implode (l : char list) : string =
  raise NotImplemented

(* ------------------------------------------------------------------------*)
(* Q2 : Bank Account *)
(* ------------------------------------------------------------------------*)

let open_account (pass: password) : bank_account =
  raise NotImplemented
;;

