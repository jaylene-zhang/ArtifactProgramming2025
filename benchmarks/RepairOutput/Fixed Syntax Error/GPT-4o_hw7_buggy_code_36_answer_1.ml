```ocaml
(*--------------------------------------------------------------*)
(* Q1 : String to Characters to String *)
(*--------------------------------------------------------------*)

(* 1.1 Turn a string into a list of characters. *)
let string_explode (s : string) : char list =
  let rec explode_helper i =
    if i >= String.length s then []
    else String.get s i :: explode_helper (i + 1)
  in
  explode_helper 0

(* 1.2 Turn a list of characters into a string. *)
let string_implode (l : char list) : string =
  List.fold_right (fun x y -> Char.escaped x ^ y) l ""

(* ------------------------------------------------------------------------*)
(* Q2 : Bank Account *)
(* ------------------------------------------------------------------------*)

type password = string
type bank_account = {
  update_pass : password -> password -> unit;
  retrieve : password -> int -> unit;
  show_balance : password -> int;
  deposit : password -> int -> unit;
}

exception Wrong_pass

let open_account (pass: password) : bank_account =
  let balance = ref 0 in 
  let passw = ref pass in
  
  {
    update_pass = (fun oldPass newPass ->
      if oldPass = !passw then passw := newPass else raise Wrong_pass);
    retrieve = (fun nowPass amt ->
      if nowPass = !passw then
        if !balance >= amt then balance := !balance - amt
        else raise (Failure "Insufficient funds")
      else raise Wrong_pass);
    show_balance = (fun nowPass ->
      if nowPass = !passw then !balance else raise Wrong_pass);
    deposit = (fun nowPass amt ->
      if nowPass = !passw then balance := !balance + amt else raise Wrong_pass)
  }
;;
```