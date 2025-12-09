Here is the fixed code:

```ocaml
(* ------------------------------------------------------------------------*)
(* Q2 : Bank Account *)
(* ------------------------------------------------------------------------*)

let open_account (pass: password) : bank_account =
  let curr_pass = ref pass in                                                 
  let curr_bal = ref 0 in {                                                         
    update_pass =                                                         
      (fun old_pass (new_pass : password) ->                                           
         if not (!curr_pass = old_pass) then raise wrong_pass else             
           curr_pass := new_pass                                          
      );                                                                  
    retrieve =                                                            
      (fun pass value ->                                                  
         if not (!curr_pass = pass) then raise wrong_pass else                 
         if value >!curr_bal then raise not_enough_balance else        
         if value < 0 then raise negative_amount else                 
           curr_bal :=!curr_bal - value                              
      );                                                                  
    deposit =                                                             
      (fun pass value ->                                                  
         if not (!curr_pass = pass) then raise wrong_pass else                 
         if value < 0 then raise negative_amount else                 
           curr_bal :=!curr_bal + value                              
      );                                                                  
    show_balance =                                                        
      (fun pass ->                                                        
         if not (!curr_pass = pass) then raise wrong_pass else                 
          !curr_bal                                                      
      )                                                                   
  }      
;;
```
Note that I added `ref` to `curr_pass` and `curr_bal` to make them mutable references, and also changed `curr_pass := old_pass` to `curr_pass := new_pass` in the `update_pass` function to correctly update the password.