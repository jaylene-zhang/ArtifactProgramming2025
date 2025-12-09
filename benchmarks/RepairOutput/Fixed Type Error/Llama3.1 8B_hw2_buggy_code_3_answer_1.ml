```haskell
(* Question 4 *)


(* TODO: Implement {!diff}. *)
let rec diff (e : exp) : exp =
 
  match e with 
 
  | Plus (l,r) ->  (diff l) +. (diff r)  // <--- Added a dot here
 
  | Times (l,r) -> ((diff l) *. r) +. (diff r *. l)
 
  | Pow (l,r) -> r *. (float_of_int (r - 1)) *. (diff l)
  
  | Var -> 1
      
  | Const f -> 0 
```