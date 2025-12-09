```ocaml
let rec diff (e : exp) : exp = 
    
  match e with 
    
  | Plus (l,r) -> Plus ((diff l), (diff r))
                               
  | Times (l,r) -> Plus ((Times ((diff l), r)), (Times ((diff r), l)))
                                        
  | Pow (l,r) -> Times (Times (r, Pow (l, (nat_sub r Z))), (diff l))
  
  | Var -> Const 1
      
  | Const f -> Const 0
```