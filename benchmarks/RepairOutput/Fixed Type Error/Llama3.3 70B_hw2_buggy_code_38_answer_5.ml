Here is the fixed code:

```
let rec diff (e : exp) : exp = 
  match e with 
  | Plus (l,r) -> Plus (diff l,diff r)
  | Times (l,r) -> Plus (Times (diff l,r), Times (l,diff r))
  | Pow (l,r) -> Times (Const (float_of_int r), Times (Pow (l,float_of_int(r-1)) , (diff l)))
  | Var -> Const 1.0
  | Const f -> Const 0.0
```