```ocaml
(* Question 4 *)


(* TODO: Implement {!diff}. *)
let rec diff (e : exp) : exp = 
    
  match e with 
    
  | Plus (l,r) -> Plus ((diff l), (diff r))
                               
  | Times (l,r) -> Plus (Times ((diff l), r), Times ((diff r), l))
                                        
  | Pow (l,r) -> Times (Times (Const (float_of_int r), Pow (l, r-1)), (diff l))
  
  | Var -> Const 1.0
      
  | Const f -> Const 0.0
```