```ocaml
let rec diff (e : exp) : exp = 
    
  match e with 
    
  | Plus (l,r) -> Plus (diff l, diff r)
                               
  | Times (l,r) -> Plus ((diff l) *. r, (diff r) *. l)
                                        
  | Pow (l,r) -> Mult (r, Plus ((diff l) *. Pow (l, float_of_int (r-1)), Pow (l, r) *. diff l))
  
  | Var -> Const 1
      
  | Const f -> Const 0
```