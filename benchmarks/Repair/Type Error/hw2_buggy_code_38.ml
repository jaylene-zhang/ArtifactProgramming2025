
let rec diff (e : exp) : exp = 
    
  match e with 
    
  | Plus (l,r) -> Plus (diff l,diff r)
                               
  | Times (l,r) -> Plus ((Times ((diff l),r), Times ((diff r),l)))
                                        
  | Pow (l,r) -> Times (Times (Const r, Pow (l,float_of_int(r-1))) , (diff l))

  | Var -> 1
      
  | Const f -> 0
