``` OCaml
let rec diff (e : exp) : exp =
  match e with
  | Plus (l,r) -> Plus (diff l,diff r)
  
  | Times (l,r) -> Plus ((Times ((diff l),r), Times ((diff r),l)))
  
  | Pow (l,r) -> 
    let aux (x : exp) (y : float) : exp = 
    Times ((((diff x)), Const(y))), x) 
    in
    Times(aux (Pow (l, float_of_int(r-1))), l)
  
  | Var -> 1
      
  | Const f -> 0
```