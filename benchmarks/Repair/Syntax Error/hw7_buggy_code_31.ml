(*--------------------------------------------------------------*)
(* Q1 : String to Characters to String                  *)
(*--------------------------------------------------------------*)

(* 1.1 Turn a string into a list of characters. *)
let string_explode (s : string) : char list =
  let f = fun x -> String.get s x in 
  tabulate f (String.length s )


(* 1.2 Turn a list of characters into a string. *)
let string_implode (l : char list) : string =
  let f = fun x y -> x ^ (Char. escaped y) in 
  List.fold_left f "" l

(* ------------------------------------------------------------------------*)
(* Q2 : Bank Account *)
(* ------------------------------------------------------------------------*)

let open_account (pass: password) : bank_account =
  let current_password = ref pass in 
  let current_balance = 0 in 
  {
    (update_pass = fun x y -> 
        if x = current_password then current_password := y
        else raise wrong_pass
    ),
    (deposit = fun x y -> 
        if x = current_password then
          if y >= 0 then current_balance := !current_balance + y
          else raise negative_amount
        else raise wrong_pass
    ),
    (retrieve = fun x y -> 
        if x = current_password then
          if y >= 0 then 
            if y > current_balance then raise not_enough_balance
            else current_balance := !current_balance - y 
          else raise negative_amount
        else raise wrong_pass 
    ),
      
    (
      show_balance = fun x -> 
        if x = current_password then current_balance
        else raise wrong_pass
    )
  }
;;

