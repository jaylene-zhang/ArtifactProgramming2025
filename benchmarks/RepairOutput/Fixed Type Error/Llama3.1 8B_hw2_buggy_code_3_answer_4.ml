let rec diff (e : exp) : exp = 
    
  match e with 
    
  | Plus (l,r) -> (diff l) +. (diff r)  (* changed to. ( unary plus ) *)
                               
  | Times (l,r) -> ((diff l) *. r) +. ((diff r) *. l)
                                        
  | Pow (l,r) -> r *. (float_of_int(r-1)) *. (diff l)  (* used float_of_int *)
  
  | Var -> 1
      
  | Const f -> 0