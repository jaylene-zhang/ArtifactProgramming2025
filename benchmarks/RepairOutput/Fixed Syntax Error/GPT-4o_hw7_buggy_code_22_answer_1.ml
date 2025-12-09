```ocaml
(*--------------------------------------------------------------*)
(* Q1 : String to Characters to String                  *)
(*--------------------------------------------------------------*)

(* 1.1 Turn a string into a list of characters. *)
let string_explode (s : string) : char list =
  let len = String.length s in
  let rec explode_aux i acc =
    if i < 0 then acc
    else explode_aux (i - 1) (s.[i] :: acc)
  in
  explode_aux (len - 1) []

(* 1.2 Turn a list of characters into a string. *)
let string_implode (l : char list) : string =
  let buffer = Buffer.create (List.length l) in
  List.iter (Buffer.add_char buffer) l;
  Buffer.contents buffer

(* ------------------------------------------------------------------------*)
(* Q2 : Bank Account *)
(* ------------------------------------------------------------------------*)

type password = string

type bank_account = {
  passw: password;
  money: int 
}

let open_account (pass: password) : bank_account =
  {
    passw = pass;
    money = 0; 
  }

let update_pass account po pn = 
  if po = account.passw then 
    { account with passw = pn }
  else
    account
```