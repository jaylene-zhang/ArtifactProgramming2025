```
let rec diff (e : exp) : exp = 
    
  match e with 
    
  | Plus (l,r) -> (diff l) + (diff r)
                               
  | Times (l,r) -> (diff l) *. r +. (diff r) *. l
                                        
  | Pow (l,r) -> r *. (diff l) ** float_of_int (r - 1)
  
  | Var -> 1
      
  | Const f -> 0
```