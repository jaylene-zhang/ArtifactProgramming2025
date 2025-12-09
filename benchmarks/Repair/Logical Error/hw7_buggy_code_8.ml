(*--------------------------------------------------------------*)
(* Q1 : String to Characters to String                  *)
(*--------------------------------------------------------------*)

(* 1.1 Turn a string into a list of characters. *)
let string_explode (s : string) : char list = 
  (* nums of chars *) 
  let str_len = String.length s in 
  (* this just created a list of length of our characters *)
  let lst_index = tabulate (fun x -> x) str_len in
  List.map (String.get s) lst_index 
    
    

(* 1.2 Turn a list of characters into a string. *)
let string_implode (l : char list) : string = 
  let str_lst = List.map Char.escaped l in
  List.fold_left (fun x y -> x^y) "" str_lst
  

(* ------------------------------------------------------------------------*)
(* Q2 : Bank Account *)
(* ------------------------------------------------------------------------*)

let open_account (pass: password) : bank_account =
  let money = ref 0 in 
  let mypass = ref pass in 
  {update_pass = (fun opass new_pass -> 
       if opass = pass then mypass := new_pass
       else raise wrong_pass);
   retrieve = (fun ipass amt -> if ipass = pass && !money > amt then money := !money - amt
                else if ipass != pass then raise wrong_pass 
                else raise not_enough_balance); 
   deposit = (fun ipass amt -> if ipass = pass then money := !money + amt
               else raise wrong_pass); 
   show_balance = (fun ipass -> if ipass = pass then ()
                    else raise wrong_pass; !money ); }
  
  
  
  
  
  
  
  
  
  
  
  
  
  

