```haskell
let rec diff (e : exp) : exp =
  match e with
  | Plus (l,r) -> (diff l) +. (diff r)
  | Times (l,r) -> ((diff l) *. r) +. ((diff r) *. l)
  | Pow (l,r) -> r *. (l ** float_of_int (r - 1)) +. (diff l)
  | Var -> 1.0
  | Const f -> 0.0
```