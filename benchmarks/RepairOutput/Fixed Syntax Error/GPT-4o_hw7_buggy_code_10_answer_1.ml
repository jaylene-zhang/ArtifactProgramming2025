```ocaml
(*--------------------------------------------------------------*)
(* Q1 : String to Characters to String                  *)
(*--------------------------------------------------------------*)

(* 1.1 Turn a string into a list of characters. *)
let string_explode (s : string) : char list = 
  List.init (String.length s) (fun a -> String.get s a)

(*1.2 Turn a list of characters into a string. *)
let string_implode (l : char list) : string =
  List.fold_right (fun i n -> (Char.escaped i) ^ n) l ""
    
(* let string_implode (l : char list) : string =
   List.fold_left (fun n i -> n ^ (Char.escaped i)) "" l *)

(* ------------------------------------------------------------------------*)
(* Q2 : Bank Account *)
(* ------------------------------------------------------------------------*)

type password = string

exception Wrong_pass
exception Negative_amount
exception Not_enough_balance

type bank_account = {
  update_pass: password -> password -> unit;
  deposit: password -> int -> unit;
  retrieve: password -> int -> unit;
  show_balance: password -> int;
}

let open_account (pass: password) : bank_account =
  let c = ref pass in 
  let amountog = ref 0 in
  let update_pass oldpass newpass = 
    if oldpass = !c then c := newpass else raise Wrong_pass
  in
  let deposit pass amount =
    if pass = !c && amount >= 0 then amountog := !amountog + amount
    else if amount < 0 then raise Negative_amount
    else raise Wrong_pass
  in
  let retrieve pass amount =
    if pass = !c && amount >= 0 && amount <= !amountog then amountog := !amountog - amount
    else if amount < 0 then raise Negative_amount
    else if amount > !amountog then raise Not_enough_balance
    else raise Wrong_pass
  in
  let show_balance pass =
    if pass = !c then !amountog else raise Wrong_pass
  in
  {update_pass; deposit; retrieve; show_balance}
```