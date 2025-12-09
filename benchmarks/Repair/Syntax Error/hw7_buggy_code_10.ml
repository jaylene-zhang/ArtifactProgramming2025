(*--------------------------------------------------------------*)
(* Q1 : String to Characters to String                  *)
(*--------------------------------------------------------------*)

(* 1.1 Turn a string into a list of characters. *)
let string_explode (s : string) : char list = 
  tabulate (fun a -> String.get s a) (String.length s)

    (*1.2 Turn a list of characters into a string. *)
let string_implode (l : char list) : string =
  List.fold_right (fun i n->  (Char.escaped i) ^ n) l ""
    
    (*let string_implode (l : char list) : string =
       List.fold_left (fun n i-> n ^ (Char.escaped i)) "" l*)
    

(* ------------------------------------------------------------------------*)
(* Q2 : Bank Account *)
(* ------------------------------------------------------------------------*)

let open_account (pass: password) : bank_account =
  let c =  ref pass in 
  let amountog = ref 0 in
  let {update_pass; deposit; retrieve; show_balance} = 
    {(fun oldpass newpass -> if (oldpass = c) then c:=newpass else raise wrong_pass);
     (fun pass amount -> if (pass = c && amount>(-1)) then amountog:= (!amountog+amount) 
       else if (amount<0) then raise negative_amount
       else raise wrong_pass);
     (fun pass amount -> if (pass = c && amount>(-1) && amount<!amountog) then amountog:= (!amountog-amount) 
       else if (amount<0) then raise negative_amount
       else if (amount>!amountog) then raise not_enough_balance
       else raise wrong_pass);
     (fun pass -> if (pass = c) then !amountog)}
    
    
;;

