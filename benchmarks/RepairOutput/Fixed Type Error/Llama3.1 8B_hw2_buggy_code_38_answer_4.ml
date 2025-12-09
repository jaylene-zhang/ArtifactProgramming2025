```hive
let rec diff (e : exp) (r : float) : exp = 
  match e with 
  | Plus (l,r) -> Plus (diff l r, diff r r) 
  | Times (l,r) -> Plus (Times (diff l r, r), Times (Times (diff r r, l), r)) 
  | Pow (l,r) -> Times (Times (Const r, Pow (l, float_of_int(r-1))), diff l r) 
  | Var -> Const 1 
  | Const f -> Const 0 
            
  ```