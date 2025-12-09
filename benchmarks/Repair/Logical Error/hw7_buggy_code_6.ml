(*--------------------------------------------------------------*)
(* Q1 : String to Characters to String                  *)
(*--------------------------------------------------------------*)

(* 1.1 Turn a string into a list of characters. *)
let string_explode (s : string) : char list =
  tabulate (fun a -> String.get s a) (String.length s)

(* 1.2 Turn a list of characters into a string. *)
let string_implode (l : char list) : string =
  let s_list (l : char list) : string list = List.map (fun a -> (Char.escaped a)) l
  in
  List.fold_right (fun x acc -> x ^ acc) (s_list l) ""

(* ------------------------------------------------------------------------*)
(* Q2 : Bank Account *)
(* ------------------------------------------------------------------------*)

let open_account (pass: password) : bank_account =
  let c, balance = ref pass, ref 0
  in
  {
    update_pass = (fun old_p new_p ->
        if (!c = old_p) then
          c := new_p
        else
          raise wrong_pass);
    retrieve = (fun p amount -> 
        if (!c != p) then raise wrong_pass
        else
        if (amount < 0) then raise negative_amount
        else 
        if ((!balance - amount) <0) then raise not_enough_balance
        else
          balance := !balance - amount);
    deposit = (fun p amount ->
        if (!c != p) then raise wrong_pass
        else
        if (amount < 0) then raise negative_amount
        else 
          balance := !balance + amount);
    show_balance = (fun p -> !balance);}
        
    
      
    