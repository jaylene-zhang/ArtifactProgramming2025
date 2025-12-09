(*--------------------------------------------------------------*)
(* Q1 : String to Characters to String                  *)
(*--------------------------------------------------------------*)

(* 1.1 Turn a string into a list of characters. *)
let string_explode (s : string) : char list = 
  List.map (String.get s) (tabulate (fun x -> x) (String.length s))
      

(* 1.2 Turn a list of characters into a string. *)
let string_implode (l : char list) : string =
  List.fold_left (^) ("") (List.map (Char.escaped) l)

(* ------------------------------------------------------------------------*)
(* Q2 : Bank Account *)
(* ------------------------------------------------------------------------*)

let open_account (pass: password) : bank_account =
  let password = ref pass in
  let balance = ref 0 in 
    
  {
    update_pass = 
      (fun old_pass new_pass -> 
         if old_pass = !password then password := new_pass else raise wrong_pass);
          
    deposit = (fun p amt ->
        if p != !password then balance := !balance + amt else raise wrong_pass);
              
    retrieve = (fun p amt -> 
        if p = !password then 
          if amt < 0 then raise negative_amount else 
          if amt <= !balance then balance := !balance - amt else
            raise not_enough_balance);
      
    show_balance = (fun p ->
        if p = !password then !balance else raise wrong_pass);
      
  }
          
    (*type rec_counter = { tick: unit -> int; reset: unit -> unit; } 
     let make_counter () : rec_counter = let c =ref 0 
       in { tick = (fun () -> c := !c + 1; !c); reset = (fun () -> c := 0); }
          
          
         The := operator is used to edit the record field
    The != operator is used to read the value inside the record field
  
*)

