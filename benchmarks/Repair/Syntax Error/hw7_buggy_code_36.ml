(*--------------------------------------------------------------*)
(* Q1 : String to Characters to String                  *)
(*--------------------------------------------------------------*)

(* 1.1 Turn a string into a list of characters. *)
let string_explode (s : string) : char list =
  tabulate (String.get s) (String.length s)

(* 1.2 Turn a list of characters into a string. *)
let string_implode (l : char list) : string =
  List.fold_right (fun x y ->  (Char.escaped x ) ^ y)  l ""

(* ------------------------------------------------------------------------*)
(* Q2 : Bank Account *)
(* ------------------------------------------------------------------------*)

let open_account (pass: password) : bank_account =
  let balance = ref 0 in 
  let passw = ref pass in
  
  {
    update_pass = (fun oldPass newPass -> if oldPass = !passw then  passw := newPass else raise wrong_pass);
    retrieve = (fun nowPass amt -> if nowPass= !passw then 
                   if !balance >= amt then balance := !balance - amt else balance:= 0  else raise wrong_pass);
    show_balance = (fun nowPass -> if nowPass= !passw then balance := !balance; !balance else raise wrong_pass);
deposit= (fun nowPass amt -> if nowPass= !passw then balance:= !balance +amt else raise wrong_pass)
}
;;

