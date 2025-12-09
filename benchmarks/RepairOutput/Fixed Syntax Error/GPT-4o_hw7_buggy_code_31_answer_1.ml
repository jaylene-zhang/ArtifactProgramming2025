```ocaml
(*--------------------------------------------------------------*)
(* Q1 : String to Characters to String                  *)
(*--------------------------------------------------------------*)

(* 1.1 Turn a string into a list of characters. *)
let string_explode (s : string) : char list =
  let f = fun x -> String.get s x in 
  List.init (String.length s) f

(* 1.2 Turn a list of characters into a string. *)
let string_implode (l : char list) : string =
  let f = fun x y -> x ^ (Char.escaped y) in 
  List.fold_left f "" l

(* ------------------------------------------------------------------------*)
(* Q2 : Bank Account *)
(* ------------------------------------------------------------------------*)

type bank_account = {
  update_pass : string -> string -> unit;
  deposit : string -> int -> unit;
  retrieve : string -> int -> unit;
  show_balance : string -> int
}

let open_account (pass: string) : bank_account =
  let current_password = ref pass in 
  let current_balance = ref 0 in 
  {
    update_pass = (fun x y -> 
      if x = !current_password then current_password := y
      else raise (Failure "wrong_pass")
    );
    deposit = (fun x y -> 
      if x = !current_password then
        if y >= 0 then current_balance := !current_balance + y
        else raise (Failure "negative_amount")
      else raise (Failure "wrong_pass")
    );
    retrieve = (fun x y -> 
      if x = !current_password then
        if y >= 0 then 
          if y > !current_balance then raise (Failure "not_enough_balance")
          else current_balance := !current_balance - y 
        else raise (Failure "negative_amount")
      else raise (Failure "wrong_pass")
    );
    show_balance = (fun x -> 
      if x = !current_password then !current_balance
      else raise (Failure "wrong_pass")
    )
  }
;;
```