let rec diff (e : exp) : exp = 
    
  match e with 
    
  | Plus (l,r) -> Plus (diff l,diff r)
                               
  | Times (l,r) -> Plus ((Times ((diff l),r)), Times ((diff r),l))
                                        
  | Pow (l,r) -> Times (Times (Const (float_of_int r), Pow (l,pow_minus_one r)), (diff l))

  | Var -> Const 1
      
  | Const f -> Const 0


and pow_minus_one (n : int) : int = n - 1